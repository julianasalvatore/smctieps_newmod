<?php
    require_once("../../model/funcoesUtil.php");

    $cursoEditarPost = file_get_contents("php://input");
    $cursoEditar = json_decode($cursoEditarPost, true);

    if(empty($cursoEditar) || is_null($cursoEditar)){
        respostaJson(true, "Nenhum curso foi recebido para edição.");
    }

    $con = getConexao();

    try{
        $sql = "UPDATE curso 
                SET nome = ?, descricao = ?, grade_curricular = ?, nivel = ?, requisitos = ?, duracao = ?, localidade = ?, link_img = ?
                WHERE id = ?";

        $ps = $con->prepare($sql);
        $ps->bindParam(1, $cursoEditar["nome"]);
        $ps->bindParam(2, $cursoEditar["descricao"]);
        $ps->bindParam(3, $cursoEditar["grade_curricular"]);
        $ps->bindParam(4, $cursoEditar["nivel"]);
        $ps->bindParam(5, $cursoEditar["requisitos"]);
        $ps->bindParam(6, $cursoEditar["duracao"]);
        $ps->bindParam(7, $cursoEditar["localidade"]);
        $ps->bindParam(8, $cursoEditar["link_img"]);
        $ps->bindParam(9, $cursoEditar["id"]);

        $ps->execute();

        respostaJson(false, "Curso de número ".$con->lastInsertId()." alterado com sucesso!");
    }
    catch(PDOException $erro){
        respostaJson(true, "Não foi possível editar o curso");
    }
?>