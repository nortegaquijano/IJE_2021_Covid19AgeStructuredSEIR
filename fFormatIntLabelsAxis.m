function labels = fFormatIntLabelsAxis(axisDir)

if(axisDir=='x')
    
    nn = length(xticklabels);
    xMinMax = xlim;
    labelNumbers = round(linspace(xMinMax(1),xMinMax(2),nn));
    for ii=1:nn
        labels{ii} = sprintf('%d',labelNumbers(ii));
    end
    xticklabels(labels);
    
elseif(axisDir=='y')
    
    nn = length(yticklabels);
    yMinMax = ylim;
    labelNumbers = round(linspace(yMinMax(1),yMinMax(2),nn));
    for ii=1:nn
        labels{ii} = sprintf('%d',labelNumbers(ii));
    end
    yticklabels(labels);
    
elseif(axisDir=='z')
    
    nn = length(zticklabels);
    zMinMax = zlim;
    labelNumbers = round(linspace(zMinMax(1),zMinMax(2),nn));
    for ii=1:nn
        labels{ii} = sprintf('%d',labelNumbers(ii));
    end
    zticklabels(labels);
    
end