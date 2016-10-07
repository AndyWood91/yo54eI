function drawShape(col, shapes, locations)

    cgpencol(col);
    cgpenwid(1);
    
    for j=1:numel(shapes)
        shape = shapes(j);
        location = locations(j);
    
        switch location
            case 1; x=0; y=105;
            case 2; x=80; y=80;
            case 3; x=105; y=0;
            case 4; x=80; y=-80;
            case 5; x=0; y=-105;
            case 6; x=-80; y=-80;
            case 7; x=-105; y=0;
            case 8; x=-80; y=80;
        end

        switch shape
            case 1 % little triangle
                size = 20;
                triang_x = [x-size/2 x  x+size/2];
                triang_y = [y-size/2 y+size/2 y-size/2];
                cgpolygon(triang_x, triang_y)
            case 2 % large triangle
                size = 40;
                triang_x = [x-size/2 x  x+size/2];
                triang_y = [y-size/2 y+size/2 y-size/2];
                cgpolygon(triang_x, triang_y)
            case 3 % little square
                size = 20;
                square_x = [x-size/2 x-size/2 x+size/2 x+size/2];
                square_y = [y-size/2 y+size/2 y+size/2 y-size/2];
                cgpolygon(square_x, square_y)
            case 4 % large square
                size = 40;
                square_x = [x-size/2 x-size/2 x+size/2 x+size/2];
                square_y = [y-size/2 y+size/2 y+size/2 y-size/2];
                cgpolygon(square_x, square_y)
            case 5 % little ellipse
                size = 20;
                cgellipse(x, y, size, size, 'f')
            case 6 % large ellipse
                size = 40;
                cgellipse(x, y, size, size, 'f')
            case 7 % little line
                cgpenwid(5);
                cgdraw(x, y, 0, 0);
            case 8 % large line
                cgpenwid(25); 
                cgdraw(x, y, 0, 0);
        end
    
    end % end of for
    
end