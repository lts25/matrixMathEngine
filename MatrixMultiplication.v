/*
    Matrix multiplication module multiplies two matrices and outputs the result once it recieves two 
    separate matices. Variable slappy keeps track of how many matrices have been recieved since last output
*/

module MatrixMultiplication (dataOut, dataInBus);
    output [255:0] dataOut;
    input [255:0] dataInBus;
    
    reg [255:0] dataOut;
    
    reg [255:0] regOut;
    reg [15:0] matMerc[3:0][3:0];
    reg [15:0] matCol[3:0][3:0];
    reg [15:0] matTatami[3:0][3:0];
    reg [3:0] i;
    reg [3:0] j;
    reg [3:0] k;
    reg slappy;
    
    initial
    begin
        slappy = 0;
        for(i=0;i<4;i=i+1)
        begin
            for(j=0;j<4;j=j+1)
            begin
                matTatami[i][j] = 0;
            end
        end
        $display("%p", matTatami);
    end
    
    always @ dataInBus
    begin
        if(slappy == 0)
        begin
            for(i=0;i<4;i=i+1)
            begin
                for(j=0;j<4;j=j+1)
                begin
                    matMerc[i][j] = dataInBus[i*64+16*j+:16];
                end
            end
            slappy = 1;
        end
        else if (slappy == 1)
        begin
            for(i=0;i<4;i=i+1)
            begin
                for(j=0;j<4;j=j+1)
                begin
                    matCol[i][j] = dataInBus[i*64+16*j+:16];
                end
            end
            for(i=0;i<4;i=i+1)
            begin
                for(j=0;j<4;j=j+1)
                begin
                    for(k=0;k<4;k=k+1)
                    begin
                        matTatami[i][j] = matTatami[i][j] + (matMerc[i][k]*matCol[k][j]);
                    end
                end
            end
            $display("%p", matTatami);
            $displayh("%p", matTatami);
            for(i = 0;i<4;i = i +1)
			begin
				for(j=0;j<4;j = j +1)
					begin
						regOut[i*64+16*j+:16] = matTatami[i][j];
					end
			end
            dataOut = regOut;
            slappy = 0;
        end
    end
    
endmodule
