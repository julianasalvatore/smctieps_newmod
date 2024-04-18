import { fazFetch } from "./funcoesUtil.js";

(()=>{
    const params = new URLSearchParams(window.location.search);
    const nomeCurso = params.get('curso');
    
    document.querySelector("title").textContent = nomeCurso;
    
    buscarCurso(nomeCurso);
})()


function buscarCurso(nomeCurso){
    // console.log(nomeCurso)
    fazFetch("POST", "../../controller/cursos/cursosBuscar.php", {"nome": nomeCurso})
    .then(resposta => {
        if(resposta.erro){
            throw new Error(resposta.msg);
        }
        carregarCurso(resposta.dados[0]);
    })
    .catch(erro => {
        console.log(erro);
    })
}   


function carregarCurso(curso){
    console.log(curso);
    const img = document.querySelector("#curso_img");
    img.setAttribute("src", curso.link_img);

    const nome = document.querySelector("#curso_nome");
    nome.textContent = curso.nome;
    
    const descricao = document.querySelector("#curso_descricao");
    descricao.textContent = curso.descricao;

    if(curso.dias_de_aula !== ""){
        const dias = document.querySelector("#curso_dias");
        dias.innerHTML = `<strong>Dias na semana: </strong> ${curso.dias_de_aula}`;
    }
    
    if(curso.horario !== ""){
        const horario = document.querySelector("#curso_horario");
        horario.innerHTML = `<strong>Horário(s): </strong> ${curso.horario}`;
    }
    if(curso.duracao !== ""){
        const duracao = document.querySelector("#curso_duracao");
        duracao.innerHTML = `<strong>Duração: </strong> ${curso.duracao}`;
    }

    if(curso.nivel !== ""){
        const nivel = document.querySelector("#curso_nivel");
        nivel.innerHTML = `<strong>Nível: </strong> ${curso.nivel}`;
    }

    if(curso.requisitos !== ""){
        const requisitos = document.querySelector("#curso_requisitos");
        requisitos.innerHTML = `<strong>Requisitos: </strong> ${curso.requisitos}`;
    }
}