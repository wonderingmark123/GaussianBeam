classdef  GaussianBeamInfo < GaussianBeam
    properties
        Position = 0;
        Lock = 'None';
        Name = 'None';
        Properties = 'None';
        Optics = 'None';
    end
    methods (Access = private)


    end
    methods (Access = public)
        %         Optics,Position (mm),Relative position (mm),Properties,Waist(μm),Waist Position(mm),Rayleigh range(mm),Divergence(mrad),Name,Lock
        function NewBeam = GaussianBeamInfo(Optics,Position,Properties,Waist,WaistPos,Name,Lock,Wavelength)
                    NewBeam@GaussianBeam(Waist,WaistPos,Wavelength)
                    NewBeam.Optics = Optics;
                    NewBeam.Position = Position;
                    NewBeam.Properties = Properties;
                    NewBeam.Lock = Lock;
                    NewBeam.Name = Name;
        end
        
        function NewBeam = goThroughLens(beam,Focallength,position,Lock,name)
            a = TransimitionABCD(beam,[1,0;beam.n/Focallength],position - beam.WaistPosition);
            NewBeam = GaussianBeamInfo('Lens',position,sprintf('f = %g mm',Focallength)...
                ,a.Waist,a.WaistPosition,name,Lock,a.Wavelength);
        end


    end
end
