module Codec(
	AUD_BCLK,       //audio
	AUD_DACLRCK,    //audio
	AUD_DACDAT,     //audio
	fast,           //control
	rate,           //control
	stop,			//control
	record,         //control
	addr_fr_sram,   //sram
	data_fr_sram,   //sram
	read,           //sram
	AUD_ADCLRCK,    //audio
	AUD_ADCDAT,     //audio
	addr_to_sram,   //sram
	data_to_sram,   //sram
	write,          //sram
	address
);

	input			AUD_BCLK, AUD_DACLRCK;
	output			AUD_DACDAT;
	input			record, stop, fast;
	input	[3:0]	rate;
	output	[17:0]	addr_fr_sram;
	input	[15:0]	data_fr_sram;
	output			read;
	output	[17:0]	address;
	
	input			AUD_ADCLRCK, AUD_ADCDAT;
	output	[17:0]	addr_to_sram;
	output	[15:0]	data_to_sram;
	output			write; //stop_out
	
	reg 		AUD_DACDAT;
	reg	[17:0]	addr,addr_next, addr_to_sram;
	reg [15:0]	data_write, data_write_next, data_to_sram;
	reg [4:0]	counter, counter_next;
	reg 		ADCLRCK_prev, write;
	
	reg	[17:0]	addr_fr_sram;
	reg	[15:0]	data_read, data_read_next;
	reg			DACLRCK_prev, read;
	
	assign address = addr;
	
	always @(*) begin
		addr_next = addr;
		data_write_next = data_write;
		counter_next = counter;
		write = 1'b0;
		addr_to_sram = 18'bzzzzzzzzzzzzzzzzzz;
		data_to_sram = 16'bzzzzzzzzzzzzzzzz;
		data_read_next = data_read;
		read = 1'b0;
		addr_fr_sram = 18'bzzzzzzzzzzzzzzzzzz;
		AUD_DACDAT = 1'b0;
		if (stop) begin              // control for stop
			addr_next = 18'b0;
			data_write_next = 16'b0;
			counter_next = 5'b0;
			data_read_next = 16'b0;
		end else if (record) begin// record  mode -- four-state ADCLRCK 0-1 1-1 (1-0 0-0)
			if(ADCLRCK_prev == 1'b0 && AUD_ADCLRCK == 1'b1) begin
				if(&addr)begin                  //first data of sram will be empty
					addr_next = addr;          //and after the last data of sram ,the recording will be stoped***shoulb be fixed!
				end else begin
					addr_next = addr + 18'b1;
				end
				data_write_next = 16'b0;
				counter_next = 5'b0;
			end else if(ADCLRCK_prev == 1'b1 && AUD_ADCLRCK == 1'b1) begin
				if (counter[4] == 1)
					counter_next = counter + 5'b1;
				else begin
					counter_next = counter;
					data_write_next[counter[3:0]] = AUD_ADCDAT; //maybe have compile error
				end
			end else begin //output for sram
				if (counter[4] == 1) begin
					write = 1'b1;
					addr_to_sram = addr;
					data_to_sram = data_write;
				end
			end
		end else begin //play mode -- four-state ADCLRCK 1-0 0-0 0-1 1-1
			if(DACLRCK_prev == 1'b1 && AUD_DACLRCK == 1'b0) begin
				read = 1'b1;
				addr_fr_sram = addr;
				data_read_next = data_fr_sram;
				counter_next = 5'b0;
				if (fast) begin
					addr_next = addr + {14'b0, rate};
					if (addr[17] && (!addr_next[17])) begin
						addr_next = 18'b11_1111_1111_1111_1111;
					end
				end else begin
					if(&addr)begin                  //first data of sram will be empty
						addr_next = addr;           //and after the last data of sram ,the recording will be stoped***shoulb be fixed!
					end else begin
						addr_next = addr + 18'b1;
					end
				end
			end else if(DACLRCK_prev == 1'b0 && AUD_DACLRCK == 1'b0) begin
				if (counter[4] == 1) begin
					counter_next = counter + 5'b1;
					AUD_DACDAT = 1'b0;
				end else begin
					counter_next = counter;
					AUD_DACDAT = data_read[counter]; //maybe have compile error
				end
			end else if(DACLRCK_prev == 1'b0 && AUD_DACLRCK == 1'b1) begin
				counter_next = 5'b0;
			end else begin
				if (counter[4] == 1) begin
					counter_next = counter + 5'b1;
					AUD_DACDAT = 1'b0;
				end else begin
					counter_next = counter;
					AUD_DACDAT = data_read[counter]; //maybe have compile error
				end
			end		
		end
	end
	
	
	always@(posedge AUD_BCLK)begin
		ADCLRCK_prev <= AUD_ADCLRCK;
		data_write <= data_write_next;
		DACLRCK_prev <= AUD_DACLRCK;
		addr <= addr_next;
		data_read <= data_read_next;
		counter <= counter_next;
	end

endmodule
