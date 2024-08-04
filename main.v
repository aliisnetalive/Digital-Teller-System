module ROM (output wire [4:0] data, input reg [2:0] count, [1:0] teller); 
    wire [4:0] addr;
    assign addr = {teller, count};
    reg [4:0] ram [31:0]; 
    initial
        begin 
            $readmemh("waiting_time.txt", ram);
        end     

    assign data = ram[addr];
   
endmodule  

module sevensegment(input [4:0]data, output reg [6:0]display);
    initial 
        begin
            display = 0;
        end 

    always @(*)
        begin
            case(data)
                4'b0000 : display = 7'b1111110;
                4'b0001 : display = 7'b0110000;
                4'b0010 : display = 7'b1101101;
                4'b0011 : display = 7'b1111001;
                4'b0100 : display = 7'b0110011;
                4'b0101 : display = 7'b1011011;
                4'b0110 : display = 7'b1011111;
                4'b0111 : display = 7'b1110000;
                4'b1000 : display = 7'b1111110;
                4'b1001 : display = 7'b1111011;
                default : display = 0;
            endcase
        end
endmodule


module Teller (output wire [1:0] tellersCount, input reg teller1, teller2 , teller3);

    assign tellersCount[0] = teller1 ^ teller2 ^ teller3;
    assign tellersCount[1] = (teller1 & teller2) + (teller1 & teller3) + (teller3 & teller2) ;

endmodule 

module Control_Unit(input reg up, down, reset, T1, T2, T3, output wire [2:0]count, [6:0]time_segment, [6:0]count_segment, wire empty, wire full);

wire [1:0] teller_num;

counter pCount(count, full, empty, up, down, reset);

Teller teller(teller_num , T1, T2, T3);
wire [4:0] data;
ROM wTime(data , count, teller_num);
wire [4:0] count_seg_extend;
assign count_seg_extend = {1'b0, count};
sevensegment countseg(count_seg_extend, count_segment);
sevensegment timeseg( data, time_segment);

endmodule

module counter (output reg[2:0]count , output reg full, output reg empty,input reg up ,input reg down , input reg reset);

   initial 
        begin 
            count = 0;
            full  = 0;
            empty = 1;  
        end 
    
    always @ (posedge up , posedge down , posedge reset )
        begin
            if (reset)
                begin 
                    count = 0;
                    empty = 1;
                    full = 0;
                end  
            else if (up)
                begin  
                    if(count < 7)
                        begin
                            full = 0;                       
                            count <= count + 1;
                            if(count > 0)begin empty = 0;end                                           
                        end
                    else
                        begin
                            full = 1;
                        end
                    
                end 
            else if (down)
                begin  
                    if(count > 0)
                        begin
                            empty = 0;    
                            count <= count - 1;
                            if(count < 7)begin full = 0;end                               
                        end
                    else
                        begin
                            empty = 1;
                        end
                    
                end 


        end 
endmodule 


module Control_Unit_MUT();
reg up, down, reset, t1,t2,t3;
wire full, empty;
wire [2:0] count;
wire [6:0] time_segment;
wire [6:0] count_segment;
initial
begin
t1 = 1;
t2 = 1;
t3 = 0;
up = 1;

up = 1; #100; // shouldn't count up 1
up = 0; #100;
// should count up
up = 1; #100; //2
up = 0; #100;

down = 1; #100; //1
down = 0; #100;
down = 1; #100; //0
down = 0; #100;
up = 1; #100; // 1
up = 0; #100; 
up = 1; #100; // 2
up = 0; #100; 
reset = 1; #100; // 0
reset = 0; #100; // 0
down = 1; #100; // 0
down = 0; #100; // 0
up = 1; #100; // 1
up = 0; #100;
up = 1; #100; //2
up = 0; #100;
up = 1; #100; //3
up = 0; #100;
up = 1; #100; //4
up = 0; #100;
up = 1; #100; //5
up = 0; #100;
up = 1; #100; //6
up = 0; #100;
up = 1; #100;//7
up = 0; #100;
up = 1; #100; //7
up = 0; #100;
down = 1; #100; // 6
down = 0; #100;
end

Control_Unit ctrlunit(up, down, reset, t1, t2, t3, count, time_segment, count_segment,  empty,  full);
endmodule