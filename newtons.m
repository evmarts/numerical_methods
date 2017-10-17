x_prev = 1.5;       % initial guess x_0 for root
min_diff = 10^-5;  % minimum difference (x_k - x_k-1) we iterate to

% plot f(x) and x = 0
fg = @(x) f(x);
fplot(fg); title('f(x) = e^x - 1/2');
axis([-2 2 -1 4])
hold on;
plot([-5 5], [0 0], '--black');plot([0 0], [5 -5], '--black')

% call newton
newton(x_prev, min_diff)

%% newton performs Newton's method until min_diff
%  input  x_prev: the initial guess
%  input  min_diff: the minimum difference (x_k - x_k-1) we iterate to
%  output root_est: the estimate of the root
function root_est = newton(x_prev, min_diff)
    conv_criteria = false; % convergence criteria false until min_diff
    wait = 0.5;
    
    while (conv_criteria == false)
        x_k = x_prev - f(x_prev)/ff(x_prev);
        
        plot(x_prev, f(x_prev), 'ored');pause(wait)
        plot([x_prev, x_k],[f(x_prev), 0],'--black');pause(wait)
        plot(x_k   , 0        , '*black');pause(wait)
    
        if abs(x_prev - x_k) < min_diff
                conv_criteria = true; % criteria met
                root_est = x_k;
                title("f(x) = e^x - 1/2 = 0 at x = " + root_est);
        end
  
        x_prev = x_k;   % store this iteration's x_k for next iteration
    end
end


% f'(x) = 1/x + 1
function f_prime_val = ff(x)
    f_prime_val = exp(x);
end


% f(x) = x + ln(x)
function f_val = f(x)
    f_val = exp(x) - 1/2;
end