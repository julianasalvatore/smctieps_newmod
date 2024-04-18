<?php
    require_once("../..model/funcoesUtil.php");


    session_set_cookie_params(['httponly' => true]);
    session_start();
    session_regenerate_id(true); 


    $loginPost = file_get_contents("php://input");
    $login = json_decode($loginPost, true);

    if(empty($login)){
        respostaJson(true, "ERRO AO FAZER LOGIN - PREENCHA TODOS OS CAMPOS");
    }

    $con =  getConexao();

    $usuario = null;
    try{
        $sql = "SELECT * FROM usuario WHERE usuario.email = ? || usuario.cpf = ?";

        $ps = $con->prepare($sql);
        $ps->bindParam(1, $login["user"]);
        $ps->bindParam(2, $login["user"]);

        $ps->execute();

        $usuario = $ps->fetchAll(PDO::FETCH_ASSOC);

        if($usuario && $ps->rowCount() == 1){
            $senhaCriptografada = password_hash($login["senha"], PASSWORD_DEFAULT);
            if(password_verify($usuario["senha"], $senhaCriptografada)){
                $_SESSION["id_user"] = $usuario["id"];
                $_SESSION["usuario"] = $usuario["nome"];
                $_SESSION["msg"] = "Usuário logado";
                $usuario = [
                    "id"=> $_SESSION["id_user"],
                    "usuario"=> $_SESSION["usuario"]
                ];
                respostaJson(false, $_SESSION["msg"], $usuario);
            }   
            else{
                $_SESSION["msg"] = "Usuário ou senha inválidos.";
                respostaJson(true, $_SESSION["msg"]);
            }
        }
        else{
            $_SESSION["msg"] = "Usuário ou senha inválidos.";
            respostaJson(true, $_SESSION["msg"]);
        }
    }
    catch(PDOException $erro){
        respostaJson(true, "ERRO AO FAZER LOGIN");
    }
?>