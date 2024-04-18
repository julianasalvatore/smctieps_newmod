<?php
    require_once("../../model/funcoesUtil.php");

    $nomeCursoPost = file_get_contents("php://input");
    $nomeCurso = json_decode($nomeCursoPost, true);
    
    if(empty($nomeCurso) || is_null($nomeCurso)){
        respostaJson(true, "Nenhum curso foi recebido para a busca.");
    }

    $con = getConexao();

    try{
        $sql = "SELECT curso.nome AS Curso, turma.dias_de_aula, turma.horario, turma.modalidade
                FROM curso JOIN turma ON(turma.curso_id = curso.id)
                WHERE curso.nome = ?";
        
        $ps = $con->prepare($sql);

        $ps->bindParam(1, $nomeCurso["nome"]);

        $ps->execute();

        $turmas = $ps->fetchAll(PDO::FETCH_ASSOC);
        
        respostaJson(false, "Turmas buscadas com sucesso!", $turmas);
    }
    catch(PDOException $erro){
        respostaJson(true, "Erro ao buscar o curso");
    }

    
?>