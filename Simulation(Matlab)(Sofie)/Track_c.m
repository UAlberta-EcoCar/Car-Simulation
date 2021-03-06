classdef Track_c < handle %goofy matlab class inheritance
    %% Class containing model of Track Conditions %%
    
    properties
        OutputFolder = '';

        %Constants
        AirPressure = 0;
        RelativeHumidity = 0;
        Temperature = 0;

        AirDensity = 0;

        Incline = [];
        DataPoints = '';
        SimulationTime = [];
        TimeInterval = [];
        LapDistance = 0;
        TrackPosition = 0;
        
        %Variable arrays
    end
    
    methods 
        function obj = Track_c(SimulationTime,TimeInterval,OutputFolder)
            %classdef constructor

            obj.OutputFolder = OutputFolder;

            obj.DataPoints = floor(SimulationTime/TimeInterval);
            obj.SimulationTime = SimulationTime;
            obj.TimeInterval = TimeInterval;
        end

        function [AirDensity] = calc_AirDensity(obj)
            AirDensity=((obj.AirPressure-(obj.RelativeHumidity/100)*exp(-42800/8.314462*(1/(obj.Temperature+273.15)-1/373.15)+log(101.325)))*28.9644+(obj.RelativeHumidity/100)*exp(-42800/8.314462*(1/(obj.Temperature+273.15)-1/373.15)+log(101.325))*18.02)/(8.314462*(obj.Temperature+273.15));
        end

        function smoothtrack(obj,k)
            for n = 1:(size(obj.Incline,2)-k)
                obj.Incline(n) = np.sum(obj.Incline((n-k):(n+k))) / k / 2;
            end
        end

        function incline = calc_Incline(obj,distance)
            distance = floor(distance);
            if distance < 1
                distance = 1;
            end
            if distance >= size(obj.Incline,1)
                distance = size(obj.Incline,1)-1;
            end
            incline = obj.Incline(distance);
        end

        function plot_Profile(obj,savef)
            figure()
            plot(obj.Incline)
            ylabel('Slope (deg)')
            xlabel('Distance (m)')
            title('Track Profile')
            if savef
                savefig([obj.OutputFolder Delimiter() 'TrackProfile.fig'])
            end
            saveas(gcf,[obj.OutputFolder Delimiter() 'TrackProfile.png'])
            close
        end
    end
end
    