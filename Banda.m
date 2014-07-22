classdef Banda
    %Clase que define una banda espectral
    %   la clase incluye la scalibraciones y opciones selecionadas para
    %   cada banda
    
    properties
        path
        valores % contiene la información de los modos de interpolación (valores o opciones de no interpolacion)
        calib
        database
        reflectancias % Valores de reflectancia de cada banda para el blanco gris y negro
        X1
        dentroIm
        fueraIm
        id % Orden en la configuración
        banda % Banda espectral de la que se trata
    end
    
    methods
    end
    
end

