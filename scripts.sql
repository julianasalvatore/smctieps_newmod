DROP DATABASE IF EXISTS new_ciencia_e_tecnologia;
CREATE DATABASE new_ciencia_e_tecnologia charset=utf8 COLLATE=utf8_unicode_ci;
USE new_ciencia_e_tecnologia;


CREATE TABLE uf(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    sigla CHAR(2) NOT NULL
);


CREATE TABLE cidade(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    uf_id INT NOT NULL,
    nome VARCHAR(50) NOT NULL,

    FOREIGN KEY (uf_id) REFERENCES uf(id)
);


CREATE TABLE bairro(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cidade_id INT NOT NULL,
    nome VARCHAR(50) NOT NULL,

    FOREIGN KEY (cidade_id) REFERENCES cidade(id)
);


CREATE TABLE usuario(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    bairro_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cpf CHAR(14) NOT NULL UNIQUE,
    telefone INT NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    endereco VARCHAR(150) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN NOT NULL,

    FOREIGN KEY (bairro_id) REFERENCES bairro(id)
);


CREATE TABLE palestrante(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone INT NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    formacao TEXT NOT NULL,
    cpf CHAR(14) NOT NULL UNIQUE,
    n_registro_profissional VARCHAR(20) UNIQUE,
    certificado BLOB NOT NULL
);


CREATE TABLE aluno(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    matricula VARCHAR(100) NOT NULL UNIQUE,

    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


CREATE TABLE instrutor(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    formacao TEXT NOT NULL,
    n_registro_profissional VARCHAR(20) NOT NULL UNIQUE,
    certificado BLOB NOT NULL,
    matricula  VARCHAR(100) NOT NULL UNIQUE,
    historico_de_modificacoes LONGTEXT,

    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


CREATE TABLE direcao(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    formacao TEXT,
    n_registro_profissional VARCHAR(20) UNIQUE,
    certificado BLOB,
    matricula VARCHAR(100) UNIQUE,
    historico_de_modificacoes LONGTEXT,

    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


CREATE TABLE gestao(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    historico_de_modificacoes LONGTEXT,

    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);


CREATE TABLE curso(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    area VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL, 
    grade_curricular TEXT NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    localidade VARCHAR(100) NOT NULL
);


CREATE TABLE workshop(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    area VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL,
    grade_curricular TEXT NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    localidade VARCHAR(100) NOT NULL
);


CREATE TABLE palestra(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    palestrante_id INT NOT NULL,
    data_palestra DATE NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_termino TIME NOT NULL,
    grade_curricular TEXT NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    descricao TEXT NOT NULL,
    localidade VARCHAR(100) NOT NULL,

    FOREIGN KEY (palestrante_id) REFERENCES palestrante(id)
);


CREATE TABLE materia(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    instrutor_id INT NOT NULL,
    curso_id INT,
    workshop_id INT,
    nome VARCHAR(50) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_termino TIME NOT NULL,

    FOREIGN KEY (instrutor_id) REFERENCES instrutor(id),
    FOREIGN KEY (curso_id) REFERENCES curso(id),
    FOREIGN KEY (workshop_id) REFERENCES workshop(id)
);


CREATE TABLE turma(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    curso_id INT NOT NULL,
    workshop_id INT NOT NULL,
    palestra_id INT NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_termino TIME NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    dias_de_aula VARCHAR(60),
    modalidade VARCHAR(50) NOT NULL,

    FOREIGN KEY (curso_id) REFERENCES curso(id),
    FOREIGN KEY (workshop_id) REFERENCES workshop(id),
    FOREIGN KEY (palestra_id) REFERENCES palestra(id)
);


CREATE TABLE frequencia(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    aluno_id INT NOT NULL,
    turma_id INT NOT NULL,
    percentual_frequencia INT NOT NULL,
    frequencia INT NOT NULL,

    FOREIGN KEY (aluno_id) REFERENCES aluno(id),
    FOREIGN KEY (turma_id) REFERENCES turma(id)
);


CREATE TABLE instituicao(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    bairro_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,

    FOREIGN KEY (bairro_id) REFERENCES bairro(id)
);


CREATE TABLE curso_institucional(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    instituicao_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    nivel VARCHAR(50) NOT NULL,

    FOREIGN KEY (instituicao_id) REFERENCES instituicao(id)
);


CREATE TABLE estagiario(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    usuario_id INT NOT NULL,
    curso_institucional_id INT NOT NULL,
    matricula VARCHAR(100) NOT NULL UNIQUE,
    tce BLOB NOT NULL,
    termo_aditivo BLOB NOT NULL,

    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (curso_institucional_id) REFERENCES curso_institucional(id)
);


CREATE TABLE estagio(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    estagiario_id INT NOT NULL,
    modalidade VARCHAR(50) NOT NULL,
    setor VARCHAR(100) NOT NULL,

    FOREIGN KEY (estagiario_id) REFERENCES estagiario(id)
);

