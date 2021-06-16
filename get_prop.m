
% GET_PROP Formats property struct for input to other functions. 
%  This sets up the proper format for the property struct used in
%  evaluating functions. Units can be altered from those given, but must
%  be consistent to proper non-dimensional quantities (that is, the units
%  must candel out). 
%  
%  The default properties are those for Carbon following the work by 
%  Sipkens et al. [1]. 
%  
%  ------------------------------------------------------------------------
%  
%  REFERENCES:
%   [1] T. A. Sipkens and K. J. Daun, “Defining regimes and analytical 
%       expressions for fluence curves in pulsed laser heating of 
%       aerosolized nanoparticles,” Optics Express, 25(5), 5684-5696 
%       (2017).
%
%  AUTHOR: Timothy Sipkens


function prop = get_prop(fn)


if ~exist('fn', 'var'); fn = []; end
if isempty(fn); fn = 'carbon.json'; end


prop = read_json(fn);


%-- Vaporization properties ------------------%
prop.kb = 1.38064852e-23; % Boltzmann constant, m^2*kg/(s^2*K)
prop.R = 8.3144598; % unviersal gas constant, kg*?m^2/(s^2*K*?mol)
prop.mv = prop.M * 1.660538782e-24; % mass of the vapor, kg
prop.Rs = prop.R / prop.M; % specific gas constant, ?m^2/(s^2*K) 
prop.hvb = prop.hvb0 ./ prop.M; 
    % latent heat of vaporization at boiling point, J/kg

    
%-- Clausius-Clapeyron (C-C) equation --------%
prop.A = exp(log(prop.Pb)+prop.hvb/prop.Rs/prop.Tb); % constant for C-C equation, Pa
prop.pv = @(T) prop.A.*exp(-prop.hvref/prop.Rs./T); % C-C equation, Pa

prop.C1 = prop.kb*pi/(9*prop.Rs*prop.hvb*prop.mv)*...
    (prop.rho*prop.cp/prop.A)^2; 
        % parameter C1, as defined in Ref. [1]

end



%== READ_JSON ============================================================%
%  Read JSON structured configuration files. 
%  Allows for C++ or Javscript style commenting.
%  AUTHOR: Timothy Sipkens, 2021-04-20

function results = read_json(file)

fid = fopen(file);
raw = fread(fid, inf);  % raw file contents
str = char(raw');  % transform to char
fclose(fid);

% Remove comments.
str = erase(erase(eraseBetween( ...
    erase(eraseBetween(str, "//", newline), "//"), ...
    "/*", "*/"), "/*"), "*/");

results = jsondecode(str);

% Attempt to interpret Matlab expressions.
f_results = fields(results);
for ii=1:length(f_results)
    t0 = results.(f_results{ii});
    
    if isa(t0, 'char')
        [converted, success] = str2num(t0);
        if success
            results.(f_results{ii}) = converted;
        end
    end
end

end


