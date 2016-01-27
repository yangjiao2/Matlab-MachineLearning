%Yingda Wang  24772532 HW4 part a
clear all;
n = [21 51 101] ;
for i = 1 : 3
    
    x = -5 : (10 / n(i)) : 5;
    f = 0.5 * ( exp (-(x - 4) .^ 2) + exp (- (x + 4) .^2));
    ff = - ( exp (-(x - 4) .^ 2) .* (x - 4) + exp (- (x + 4) .^2) .* (x + 4));
    %fff = ( exp (-(x - 4) .^ 2) * (2 * (x - 4). ^2 - 1) + exp (- (x + 4) .^2) * (2  * (x + 4). ^2 - 1));


    for j = 1 : length (x) - 2
        xcentral(j) = x(j);
        central(j) = (f(j + 2) - f(j)) / (2 * 10 / n(i));
    end
    
    for j = 1 : length (x) - 2
        xthreepoint(j) = x(j);
        threepoint(j) = (-3 * f(j) + 4 * f(j+1) - f(j+2)) / (2 * 10 / n(i));
    end
    
    for j = 1 : length (x) - 4
        xfivepoint(j) = x(j);
        fivepoint(j) = (f(j) - 8 * f(j + 1) +8 * f(j + 3) - f(j + 4))/ (12 * 10 / n(i));
    end
        
    for j = 1 : length (x)
        real(j) = ff(j);
    end
        
       

    
    plot(xcentral, central, 'LineWidth',2)
    hold on

    plot(xthreepoint, threepoint, 'LineWidth',2, 'color','g')
    hold on

    plot(xfivepoint, fivepoint, 'LineWidth',2, 'color','y')
    hold on

    plot(x, real, 'LineWidth',2, 'color','r')
    hold off

    title('hw4 a')
    xlabel('x')
    ylabel('values')

    hleg = legend('central','threepoint','fivepoint','real');
    set(hleg);
    figure;
end