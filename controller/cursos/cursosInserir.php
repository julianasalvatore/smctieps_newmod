<?php
    require_once("../../model/funcoesUtil.php");

    $cursoPost = file_get_contents("php://input");
    $curso = json_decode($cursoPost, true);

    if(empty($curso) || is_null($curso)){
        respostaJson(true, "Nenhum curso foi recebido para inserção.");
    }

    $con = getConexao();

    try{
        $sql = "INSERT INTO curso(nome, descricao, grade_curricular, nivel, requisitos, duracao, localidade, link_img)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

        $ps = $con->prepare($sql);
        $ps->bindParam(1, $curso["nome"]);
        $ps->bindParam(2, $curso["descricao"]);
        $ps->bindParam(3, $curso["grade_curricular"]);
        $ps->bindParam(4, $curso["nivel"]);
        $ps->bindParam(5, $curso["requisitos"]);
        $ps->bindParam(6, $curso["duracao"]);
        $ps->bindParam(7, $curso["localidade"]);
        $ps->bindParam(8, $curso["link_img"]);
        
        $ps->execute();

        respostaJson(false, "Curso de número ".$con->lastInsertId()." inserido com sucesso!");
    }    
    catch(PDOException $erro){
        respostaJson(true, "Não foi possível inserir o curso.");
    }


?>