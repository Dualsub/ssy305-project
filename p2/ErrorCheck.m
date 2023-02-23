function [bError] = ErrorCheck(data,TypeOfErrorCheck)
%<ErrorCheck> check received frame for errors

%   Function inputs:
%       <data>                - received data
%       <TypeOfErrorCheck>    - string for the type of error check that should be
%                               performed(eg. 'parity')
%
%   Function output:
%       <bError>    - boolean variable that is [0: when no error, 1: when error]
%
%
%   Author(s):  Erik Steinmetz, Katharina Hausmair
%   Email:      estein@chalmers.se, hausmair@chalmers.se
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REVISION HISTORY                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.00, 2013-11-29, Erik Steinmetz: First version...
% 2.00, 2014-12-10, Erik Steinmetz: Second version...

%------------- BEGIN CODE --------------

switch TypeOfErrorCheck
    case 'parity'
        bError = mod(sum(data), 2); %Implement error check here   
    case 'checksum16'
        % Implement 16-bit checksum error check here

        % Reshape the input data into 16-bit segments
        data = reshape(data, 16, []);
        % Sum each column
        checksum = sum(data, 1);
        
        % Take the bitwise AND of the sum with the number 65535(16-bit
        % FFFF).
        checksum = bitand(checksum, 65535);
    
        % Sum the resulting 16-bit values together.
        checksum = sum(checksum, 'native');
        
        % Take the 1's complement of the sum by flipping all the bits.
        checksum = bitcmp(checksum, 'uint16');
        
        % Check if the result is zero, indicating no errors.
        bError = (checksum ~= 0);
    otherwise
        error('Invalid error check!')       
end

