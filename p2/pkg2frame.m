function frame = pkg2frame(packet, header, TypeOfErrorCheck)
%<pkg2frame> create info frame by adding header and error check bits (eg. parity bit)
%
%   Function inputs:
%       <packet>   - information packet that should be framed
%       <header>   - bits that should be included in header (eg. sequence number)
%       <TypeOfErrorCheck>    - string for the type of error detection (eg. 'parity')
%
%   Function output:
%       <frame>    - information frame
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
% 2.00, 2016-03-01, Katharina Hausmair: added TypeOfErrorCheck

switch TypeOfErrorCheck
    case 'parity'
        %1 calculate parity bit
        header = mod(header, 2);
        paritybit = mod(sum(packet) + sum(header), 2);
        %2 assemble the frame
        frame = [header packet paritybit];
    case 'checksum16'
        % Calculate 16-bit checksum
        
        % Reshape the input data into 16-bit segments 
        packet = reshape(packet, 16, []);
        % Sum each column
        checksum = sum(packet, 1);
        
        % Take the bitwise AND of the sum with the number 65535(16-bit FFFFF)
        checksum = bitand(checksum, 65535);
     
        % Sum the resulting 16-bit values together.
        checksum = sum(checksum, 'native');
     
        % Take the 1's complement of the sum by flipping all the bits.
        checksum = bitcmp(checksum, 'uint16');
        
        % Assemble the frame with the checksum appended
        frame = [header packet typecast(checksum, 'uint8')];
    otherwise
          error('Invalid error check!')        
end

