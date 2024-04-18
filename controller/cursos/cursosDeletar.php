<?php
    require_once("../..model/funcoesUtil.php");
    $idDeletePost = file_get_contents("php://input");
    $idDelete = json_decode($cursoDeletePost, true);

    if(empty($cursoDelete) || is_null($cursoDelete)){
        respostaJson(true, "Nenhum curso foi selecionado para remoção.");
    }

    $con = getConexao();

    try{
        $sql = "DELETE FROM curso WHERE id = ?";
        
        $ps = $con -> prepare($sql);
        $ps-> bindParam(1, $cursoDelete["id"]);

        $ps->execute();

        respostaJson(false, "Curso deletado com sucesso.");
    }
    catch(PDOException $erro){
        respostaJson(true, "Não foi possível deletar curso.");
    }
?>