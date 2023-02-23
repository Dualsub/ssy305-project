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
    case 'checksum'
        n = 16;
        csum = 0;
        ds = reshape(packet, [n, length(packet) / n]);
        display(ds);
        for d=ds
            dstr = char(d' + '0');
            csum = one_comp_add(csum, bin2dec(dstr), n);
        end
        p = xor(dec2bin(csum, 16), 2^n);
        display(dec2bin(csum, 16));
        frame = [header packet p];
        display(p);
    otherwise
          error('Invalid error check!')        
end

