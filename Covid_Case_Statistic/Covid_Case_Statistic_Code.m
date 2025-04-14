classdef Covid_Case_Statistic < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        OptionButtonGroup          matlab.ui.container.ButtonGroup
        DailyButton                matlab.ui.control.RadioButton
        CumulativeButton           matlab.ui.control.RadioButton
        DatatoPlotButtonGroup      matlab.ui.container.ButtonGroup
        BothButton                 matlab.ui.control.RadioButton
        DeathsButton               matlab.ui.control.RadioButton
        CasesButton                matlab.ui.control.RadioButton
        AveragedofdaysSlider       matlab.ui.control.Slider
        AveragedofdaysSliderLabel  matlab.ui.control.Label
        StateorRegionListBox       matlab.ui.control.ListBox
        StateorRegionListBoxLabel  matlab.ui.control.Label
        CountryListBox             matlab.ui.control.ListBox
        CountryListBoxLabel        matlab.ui.control.Label
        UIAxes                     matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        covidData       % 添加Global後的原始數據
        selectedCountryIndex   % 當前選擇的國家在原始數據中的Index
        dateCell        % 全部日期的Cell                      
        selectedDataCell    % 當前選擇的國家的所有Cell         
        date            % 全部日期                          
        caseNum         % 當前選擇的國家的所有case             
        deathNum        % 當前選擇的國家的所有death             
        countryIndexInListBox         % listBox中選擇的國家Index        
        regionIndex     % 當前選擇的國家擁有的region的index   
        selectedRegionIndex  %當前選擇的Region在原始數據中的Index
        caseAverage     % Description
        deathAverage    % Descriptionn
        averagingWindow % Description
        showCases       % Description
        showDeathes     % Description
        showCumulative  % Description
        showDaily       % Description
    end
    
    methods (Access = private)
        
        function Initialize_data(app)
            load 'Covid DATA.mat' covid_data;
            allDataCell = covid_data(2:end, 3:end);
            globalCases = sum(cellfun(@(x) x(1), allDataCell));
            globalDeaths = sum(cellfun(@(x) x(2), allDataCell));

            app.covidData = covid_data;
            globalRow = cell(1, length(globalCases));
            for i = 3:size(covid_data, 2)
                globalRow{i} = [globalCases(i-2), globalDeaths(i-2)];
            end
            app.covidData = [covid_data(1,:); globalRow; covid_data(2:end,:)];
            app.covidData{2,1} = 'Global';
            app.covidData{2,2} = '';
        end

        function Show_country(app)
            app.countryIndexInListBox = [];
            for i=1:size(app.covidData, 1)
                if isequal(app.covidData(i, 2), "")
                    app.countryIndexInListBox = [app.countryIndexInListBox, i];
                end
            end
            app.CountryListBox.Items = app.covidData(app.countryIndexInListBox, 1);
            fprintf("# of country in list box = %d\n", size(app.countryIndexInListBox, 2));
        end

        function Compute_average(app)
            app.caseAverage = movmean(app.caseNum, app.averagingWindow);
            app.deathAverage = movmean(app.deathNum, app.averagingWindow);
        end

        function Plot_data(app)
            % Show title
            location = app.CountryListBox.Value;
            region = app.StateorRegionListBox.Value;

            if isequal(location, 'Global')
                location = 'Globally';
            elseif isequal(region, 'All')
                location = ['in ', location];
            else
                location = ['in ', region];
            end
            
            app.UIAxes.Title.String = ['Cumulative Number of Cases ', location];

            % Plot data
            cla(app.UIAxes);
            
            switch app.DatatoPlotButtonGroup.SelectedObject
                case app.CasesButton
                    bar(app.UIAxes, app.date, app.caseNum, 'blue');
                case app.DeathsButton
                    plot(app.UIAxes, app.date, app.deathNum, 'red');
                otherwise
                    bar(app.UIAxes, app.date, app.caseNum, 'blue');
                    hold(app.UIAxes, 'on');
                    plot(app.UIAxes, app.date, app.deathNum, 'red');
                    hold(app.UIAxes, 'off');

            %switch app.DatatoPlotButtonGroup.SelectedObject
            %    case app.CasesButton
            %        bar(app.UIAxes, app.date, app.caseAverage, 'blue');
            %    case app.DeathsButton
            %        plot(app.UIAxes, app.date, app.deathAverage, 'red');
            %    otherwise
            %        bar(app.UIAxes, app.date, app.caseAverage, 'blue');
            %        hold(app.UIAxes, 'on');
            %        plot(app.UIAxes, app.date, app.deathAverage, 'red');
            %        hold(app.UIAxes, 'off');
            end
            drawnow;
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Initialize_data();
            app.Show_country();
            app.selectedCountryIndex = 2;
            
            app.StateorRegionListBox.Items = "All";
            
            app.dateCell = app.covidData(1, 3:end);
            app.date = datetime(app.dateCell, Format="MM/dd");
            
            app.selectedDataCell = app.covidData(app.selectedCountryIndex, 3:end);
            app.caseNum = cellfun(@(x) x(1), app.selectedDataCell);
            app.deathNum = cellfun(@(x) x(2), app.selectedDataCell);
            
            app.averagingWindow = app.AveragedofdaysSlider.Value;
            app.averagingWindow = 30;

            %app.showCases = app.CasesButton.Value || app.BothButton.Value;
            %app.showDeathes = app.DeathsButton.Value || app.BothButton.Value;
            %app.showCumulative = app.CumulativeButton.Value;
            %app.showDaily = app.DailyButton.Value;
            
            %app.Compute_average();
            app.Plot_data();
        end

        % Value changed function: CountryListBox
        function CountryListBoxValueChanged(app, event)
            % Change value
            selectedIndexInListBox = app.CountryListBox.ValueIndex;
            app.selectedCountryIndex = app.countryIndexInListBox(selectedIndexInListBox);
            fprintf("Selected country index = %d\n", app.selectedCountryIndex);

            % Show state & region
            tempCountry = app.selectedCountryIndex+1;
            app.regionIndex = [];
            if tempCountry <= size(app.covidData, 1) && isequal(app.covidData(tempCountry, 2), "")
                app.StateorRegionListBox.Items = "All";
            else
                while tempCountry <= size(app.covidData, 1) && ~isequal(app.covidData(tempCountry, 2), "")
                    app.regionIndex = [app.regionIndex, tempCountry];
                    tempCountry = tempCountry + 1;
                end
                regionListBoxItems = [{'All'}; app.covidData(app.regionIndex, 2)]; 
                app.StateorRegionListBox.Items = regionListBoxItems;    
            end

            % Draw data
            app.selectedDataCell = app.covidData(app.selectedCountryIndex, 3:end);
            app.caseNum = cellfun(@(x) x(1), app.selectedDataCell);
            app.deathNum = cellfun(@(x) x(2), app.selectedDataCell);
            %app.Compute_average
            app.Plot_data;
            fprintf("Country : %s\n", app.CountryListBox.Value);
            fprintf("Region : %s\n\n", app.StateorRegionListBox.Value);
        end

        % Value changed function: StateorRegionListBox
        function StateorRegionListBoxValueChanged(app, event)
            % Change value
            selectedIndexInListBox = app.StateorRegionListBox.ValueIndex;
            if selectedIndexInListBox == 1
                app.selectedRegionIndex = app.selectedCountryIndex;
            else
                app.selectedRegionIndex = app.regionIndex(selectedIndexInListBox-1);
            end
            fprintf("Selected region index = %d\n", app.selectedRegionIndex);
            
            % Draw data
            app.selectedDataCell = app.covidData(app.selectedRegionIndex, 3:end);
            app.caseNum = cellfun(@(x) x(1), app.selectedDataCell);
            app.deathNum = cellfun(@(x) x(2), app.selectedDataCell);
            %app.Compute_average
            app.Plot_data;
            fprintf("Region changed to : %s\n\n", app.StateorRegionListBox.Value);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 600 575];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Cumulative Number of Cases Globally')
            app.UIAxes.Position = [38 207 526 342];

            % Create CountryListBoxLabel
            app.CountryListBoxLabel = uilabel(app.UIFigure);
            app.CountryListBoxLabel.HorizontalAlignment = 'right';
            app.CountryListBoxLabel.Position = [14 180 50 22];
            app.CountryListBoxLabel.Text = 'Country:';

            % Create CountryListBox
            app.CountryListBox = uilistbox(app.UIFigure);
            app.CountryListBox.Items = {'Global', 'Item 2', 'Item 3', 'Item 4'};
            app.CountryListBox.ValueChangedFcn = createCallbackFcn(app, @CountryListBoxValueChanged, true);
            app.CountryListBox.Position = [71 31 120 173];
            app.CountryListBox.Value = 'Global';

            % Create StateorRegionListBoxLabel
            app.StateorRegionListBoxLabel = uilabel(app.UIFigure);
            app.StateorRegionListBoxLabel.HorizontalAlignment = 'right';
            app.StateorRegionListBoxLabel.Position = [201 164 46 40];
            app.StateorRegionListBoxLabel.Text = {'State or'; 'Region:'};

            % Create StateorRegionListBox
            app.StateorRegionListBox = uilistbox(app.UIFigure);
            app.StateorRegionListBox.ValueChangedFcn = createCallbackFcn(app, @StateorRegionListBoxValueChanged, true);
            app.StateorRegionListBox.Position = [258 31 83 171];

            % Create AveragedofdaysSliderLabel
            app.AveragedofdaysSliderLabel = uilabel(app.UIFigure);
            app.AveragedofdaysSliderLabel.HorizontalAlignment = 'right';
            app.AveragedofdaysSliderLabel.Position = [355 167 56 30];
            app.AveragedofdaysSliderLabel.Text = {'Averaged'; '# of days'};

            % Create AveragedofdaysSlider
            app.AveragedofdaysSlider = uislider(app.UIFigure);
            app.AveragedofdaysSlider.Limits = [1 15];
            app.AveragedofdaysSlider.Position = [424 191 150 3];
            app.AveragedofdaysSlider.Value = 1;

            % Create DatatoPlotButtonGroup
            app.DatatoPlotButtonGroup = uibuttongroup(app.UIFigure);
            app.DatatoPlotButtonGroup.Title = 'Data to Plot';
            app.DatatoPlotButtonGroup.Position = [355 31 100 105];

            % Create CasesButton
            app.CasesButton = uiradiobutton(app.DatatoPlotButtonGroup);
            app.CasesButton.Text = 'Cases';
            app.CasesButton.Position = [11 59 58 22];

            % Create DeathsButton
            app.DeathsButton = uiradiobutton(app.DatatoPlotButtonGroup);
            app.DeathsButton.Text = 'Deaths';
            app.DeathsButton.Position = [11 37 60 22];

            % Create BothButton
            app.BothButton = uiradiobutton(app.DatatoPlotButtonGroup);
            app.BothButton.Text = 'Both';
            app.BothButton.Position = [11 15 65 22];
            app.BothButton.Value = true;

            % Create OptionButtonGroup
            app.OptionButtonGroup = uibuttongroup(app.UIFigure);
            app.OptionButtonGroup.Title = 'Option';
            app.OptionButtonGroup.Position = [474 31 100 105];

            % Create CumulativeButton
            app.CumulativeButton = uiradiobutton(app.OptionButtonGroup);
            app.CumulativeButton.Text = 'Cumulative';
            app.CumulativeButton.Position = [11 59 82 22];
            app.CumulativeButton.Value = true;

            % Create DailyButton
            app.DailyButton = uiradiobutton(app.OptionButtonGroup);
            app.DailyButton.Text = 'Daily';
            app.DailyButton.Position = [11 37 65 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Covid_Case_Statistic

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
