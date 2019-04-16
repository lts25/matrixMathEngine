module MatrixMultiplication (dataOut, dataInBus, slapOff);
output [255:0] dataOut;
input [255:0] dataInBus;
input slapOff;
reg [2:0] regOut;
reg [255:0] dataOut;
reg slappy;

reg [16:0] matMerc[3:0][3:0];
reg [16:0] matCol[3:0][3:0];
reg [16:0] matTatami[3:0][3:0];
reg [255:0] matMult;
reg [17:0] intCount;
reg [3:0] rowCount;
reg [3:0] columnCount;
reg [2:0] theRow;
reg [2:0] theColumn;
 
 initial
 begin
    slappy = 0;
 end

always @ dataInBus
	begin
        intCount = 0;
        if (slappy == 0)
        begin
            $display("SLAPPY!?");
            for(rowCount = 0; rowCount < 4; rowCount = rowCount + 1)
            begin
                for (columnCount = 0; columnCount < 4; columnCount = columnCount + 1)
                begin
                    matMerc[columnCount][rowCount] <= dataInBus[intCount+:16];
                    intCount = intCount + 16;
                end
            end
            slappy = 1;
        end
        else if (slappy == 1)
        begin
            for(rowCount = 0; rowCount < 4; rowCount = rowCount + 1)
            begin
                for (columnCount = 0; columnCount < 4; columnCount = columnCount + 1)
                begin
                    matCol[columnCount][rowCount] <= dataInBus[intCount+:16];
                    intCount = intCount + 16;
                end
            end
            slappy = 0;
            for(rowCount = 0; rowCount < 4; rowCount = rowCount + 1)
            begin
                theRow = rowCount;
                for(columnCount = 0; columnCount < 4; columnCount = columnCount + 1)
                begin
                    theColumn = columnCount;
                    matTatami[columnCount][rowCount] = (matMerc[theColumn][theRow]*matCol[theColumn][theRow])+(matMerc[theColumn+1][theRow]*matCol[theColumn][theRow+1])
                                +(matMerc[theColumn+2][theRow]*matCol[theColumn][theRow+2])+(matMerc[theColumn+3][theRow]*matCol[theColumn][theRow+3]);
                    $display(matTatami[columnCount][rowCount]);
                end
            end
            intCount = 0;
            for(rowCount = 0; rowCount < 4; rowCount = rowCount + 1)
            begin
                for(columnCount = 0; columnCount < 4; columnCount = columnCount + 1)
                begin
                    matMult[intCount+:16] <= matTatami[columnCount][rowCount];
                    intCount = intCount + 1;
                end                
            end
            dataOut = matMult;
        end
        
	end
	

endmodule
