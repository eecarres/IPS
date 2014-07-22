classdef Banda < handle
    %Clase que define una banda espectral
    %   la clase incluye la scalibraciones y opciones selecionadas para
    %   cada banda
    
    properties
        LK % Imagen en reflectancias en cada momento
        path
        valores % contiene la informaci�n de los modos de interpolaci�n (valores o opciones de no interpolacion)
        calib
        database
        reflectancias % Valores de reflectancia de cada banda para el blanco gris y negro
        X1
        dentroIm
        fueraIm
        id % Orden en la configuraci�n
        banda % Banda espectral de la que se trata
    end
    
    methods
    end
    
end

