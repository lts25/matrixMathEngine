module TMatrixMultiplication;
reg [255:0] dataInBus;

wire [255:0] dataOut;
 
reg [16:0] matExcersize[3:0][3:0];
reg [16:0] matPrayer[3:0][3:0];
reg [16:0] matFloor[3:0][3:0];
reg [255:0] matYew_1;
reg [255:0] matPhew_2;

integer i, j;

MatrixMultiplication bluePill(dataOut, dataInBus);

initial
begin
    matExcersize[0][0] = 5;
    matExcersize[0][1] = 8;
    matExcersize[0][2] = 9;
    matExcersize[0][3] = 2;
    matExcersize[1][0] = 7;
    matExcersize[1][1] = 3;
    matExcersize[1][2] = 8;
    matExcersize[1][3] = 4;
    matExcersize[2][0] = 6;
    matExcersize[2][1] = 5;
    matExcersize[2][2] = 4;
    matExcersize[2][3] = 3;
    matExcersize[3][0] = 8;
    matExcersize[3][1] = 5;
    matExcersize[3][2] = 7;
    matExcersize[3][3] = 6;
    
    matPrayer[0][0] = 11;
    matPrayer[0][1] = 14;
    matPrayer[0][2] = 19;
    matPrayer[0][3] = 18;
    matPrayer[1][0] = 6;
    matPrayer[1][1] = 9;
    matPrayer[1][2] = 3;
    matPrayer[1][3] = 5;
    matPrayer[2][0] = 12;
    matPrayer[2][1] = 10;
    matPrayer[2][2] = 15;
    matPrayer[2][3] = 14;
    matPrayer[3][0] = 1;
    matPrayer[3][1] = 3;
    matPrayer[3][2] = 5;
    matPrayer[3][3] = 7;
    
    for(i = 0; i<4; i=i+1)
    begin
        for(j = 0; j<4; j=j+1)
        begin
            matYew_1[i*64+16*j+:16] = matExcersize[i][j];
            matPhew_2[i*64+16*j+:16] = matPrayer[i][j];
        end
    end
    
    #1 dataInBus = matYew_1;
    #1 dataInBus = matPhew_2;

end

always @ dataOut
begin
    $displayh("%p", dataOut);
end


/*
mat 1
5              8              9              2

7              3              8              4

6              5              4              3

8              5              7              6

mat 2
11             14             19             18

6              9              3              5

12             10             15             14

1              3              5              7

expected output
213         	238         	264         	270
195	            217         	282         	281
147	            178         	204         	210
208	            245	            302	            309

{'{309, 302, 245, 208}, '{210, 204, 178, 147}, '{281, 282, 217, 195}, '{270, 264, 238, 213}}
*/

endmodule
