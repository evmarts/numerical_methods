x_lb = -1; x_ub = 10; y_lb = -2; y_ub = 2;

a = -1; b = 10;  % initial interval
min_diff = 10^-5;  % minimum difference (x_k - x_k-1) we iterate to

% plot f(x) and x = 0
fg = @(x) f(x);
fplot(fg); title("f(x) = x + ln(x)");
axis([x_lb x_ub y_lb y_ub])
hold on;
plot([-100 100], [0 0], '--black')

p = (a+b)/2;  % compute new midpoint p

% plot left bound a, right bound b and midpoint p
plot([p p],[y_lb, y_ub],'--black');
plot([a a],[y_lb, y_ub],'blue');plot([b b],[-1, 1],'red');

% call bisection
root_est = bisection(a,b,min_diff);

%% bisect performs the bisection method on interval [a,b] until min_diff
%  input  a,b: the initial interval
%  input  min_diff: the minimum difference (x_k - x_k-1) we iterate to
%  output root_est: the estimate of the root
function root_est = bisection(a,b,min_diff) 
    conv_criteria = false; % convergence criteria false until min_diff
    p_prev = b;            % arbitrarily set p_prev to b
    wait = 0.5/2;
    
    while (conv_criteria == false)
        p = (a+b)/2;  % compute new midpoint p
        
        % delete old midpoint p and plot new midpoint p
        children = get(gca, 'children');delete(children(3));
        plot([p p],[-2, 2],'--black');pause(wait)
       
        % exact root found if f(p) == 0
        if f(p) == 0
            root_est = p;
            return
        end
        
        if sign(f(a)) == sign(f(p))
            a = p; % root is in [p,b], set interval for next iteration
        else
            b = p; % root is in [a,p], set interval for next iteration
        end
        
        % delete old a, b lines and plot new a, b lines
        children = get(gca, 'children');delete(children(2));delete(children(3));
        plot([a a],[-2, 2],'blue');
        plot([b b],[-2, 2],'red');
        pause(wait)
        
        if abs(p_prev - p) < min_diff
            conv_criteria = true; % criteria met
            plot([p p],[-2, 2],'green');
            title("root estimate = " + p)
            root_est = p;
        end
           
        p_prev = p; % store this iteration's p for next iteration
    end
    
end

% f(x) =  sin(x) + x/pi - 2;
function f_prod = f(x)
    f_prod = sin(x) + x/pi - 2;
end