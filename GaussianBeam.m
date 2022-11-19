classdef  GaussianBeam
    properties
        Waist = 100*10^-6;
        WaistPosition = 100*10^-3;
        Wavelength = 323*10^-9;
        n=1;
        Color = [1 1 1];
    end
    methods (Access = private)

    end
    methods (Access = public)
        
        function NewBeam = GaussianBeam(Waist,WaistPos,Wavelength)
            NewBeam.Waist = Waist;
            NewBeam.WaistPosition = WaistPos;
            NewBeam.Wavelength = Wavelength;
            NewBeam.Color = wavelength2color(NewBeam.Wavelength*10^9, 'gammaVal', 1, 'maxIntensity', 1, 'colorSpace', 'rgb');

        end

        function NewBeam = createGaussianBeam(beam,Rayleighlength,WaistPos)
            NewBeam.Waist = sqrt(beam.Wavelength*Rayleighlength./pi);
            NewBeam.WaistPosition = WaistPos;
            NewBeam.Wavelength = beam.Wavelength;
            NewBeam.Color = beam.Color;
        end

        function zR = rayleighLength(beam)
            zR = pi*beam.Waist.^2./beam.Wavelength;
        end
        function Da = DivAngle(beam)
            Da =  beam.Wavelength / (pi*beam.Waist);
        end
        function W= beamWidth(beam,z)
            % z is distance between beam waist and current position
            W = beam.Waist.*sqrt(1+(z./rayleighLength(beam)).^2);
        end


        function NewBeam = TransimitionABCD(beam,ABCD,z)
            Qz =  1i * (pi.* beam.Waist.^2)./beam.Wavelength;
            ABCD = ABCD * [1,-(z - beam.WaistPosition)/beam.n;0,1];
            zo  =   real((ABCD(1,1)*Qz + ABCD(1,2))./(ABCD(2,1)*Qz + ABCD(2,2)));
            Rayleighlength  =   imag((ABCD(1,1)*Qz + ABCD(1,2))./( ABCD(2,1)*Qz + ABCD(2,2) ));
            NewWaist = sqrt(beam.Wavelength*Rayleighlength./pi);
            NewBeam = GaussianBeam(NewWaist,z + zo,beam.Wavelength);
        end


        
    end
end
