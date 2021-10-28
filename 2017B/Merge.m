function matrix = Merge(data, Mat_Size)

global Latitude_Min Latitude_Merge_Length;
global Longitude_Min Longitude_Merge_Length;

Distribution = zeros(Mat_Size, Mat_Size);

for i = 1 : size(data, 1)
    Row = floor((data(i, 1) - Latitude_Min) / Latitude_Merge_Length) + 1;
    Column = floor((data(i, 2) - Longitude_Min) / Longitude_Merge_Length) + 1;
    
    if Row == Mat_Size + 1
        Row = Row - 1;
    else if Row > Mat_Size | Row < 1
            continue;
        end
    end
    
    if Column == Mat_Size + 1
        Column = Column - 1;
    else if Column > Mat_Size | Column < 1
            continue;
        end 
    end
    
    Distribution(Row, Column) = Distribution(Row, Column) + 1;
end
matrix = Distribution;
end