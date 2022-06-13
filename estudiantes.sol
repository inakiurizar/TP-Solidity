// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract colegio {

    //Creacion variables
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint8) private notas_materia;
    string[] private _nom_materias;

    //Creacion contructor que asigna las variables al smart contract y asignacion adress al docente
    constructor(string memory nombre_, string memory apellido_, string memory curso_) {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

    //Devuelve el apellido del estudiante como string 
    function apellido() public view returns (string memory) {
        return _apellido;
    }

    //Devuelve el nombre y apellido del estudiante como string
    function nombre_completo() public view returns (string memory) {
        return string(abi.encodePacked(_nombre, " " , _apellido));
    }

    //Devuelve el curso del alumno como string
    function curso() public view returns (string memory) {
        return _curso;
    }

    //El docente puede asignar notas a cualquier materia
    function set_nota_materia(uint8 _nota, string memory _materia) public {
        require(_docente == msg.sender, "Solo el docente registrado puede llamar a esta funcion");
        require(_nota <= 100 && _nota >= 1, "Solo se reciben notas entre 1 y 100");
        notas_materia[_materia] = _nota;
        _nom_materias.push(_materia);
    }

    //Devuelve la nota del Estudiante dada una materia
    function nota_materia(string memory _materia) public view returns (uint) {
        uint _notaEstudiante = notas_materia[_materia];   
        return _notaEstudiante;
    }
    
    //Devuelve true si el alumno se saco una nota mayor a 6, en el caso contrario devuelve false
    function aprobo(string memory _materia) public view returns (bool) {
        if (notas_materia[_materia] >= 60)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //Devuelve el promedio del alumno
    function promedio() public view returns (uint) {

        uint _notas = _nom_materias.length;
        uint _promedio;
        uint _notaPromediada;

        for (uint i = 0; i < _notas; i++){
            _promedio += notas_materia[_nom_materias[i]];
        }
        _notaPromediada = _promedio / _notas;
        return _notaPromediada;
    }
}