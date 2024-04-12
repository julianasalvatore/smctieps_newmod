<?php
    require_once("../../model/funcoesUtil.php");

    $nomeCursoPost = file_get_contents("php://input");
    $nomeCurso = json_decode($nomeCursoPost, true);

    if(empty($nomeCurso) || is_null($nomeCurso)){
        respostaJson(true, "Nenhum curso foi recebido para a busca.");
    }

    $con = getConexao();

    try{
        $sql = "SELECT * FROM curso WHERE curso.nome = ?";

        $ps = $con->prepare($sql);

        $ps->bindParam(1, $nomeCurso);

        $ps->execute();

        $curso = $ps->fetchAll(PDO::FETCH_ASSOC);

        respostaJson(false, "Curso listado com sucesso!", $curso);
    }
    catch(PDOException $erro){
        respostaJson(true, "Erro ao buscar o curso");
    }
?>