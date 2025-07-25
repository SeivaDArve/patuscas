# Title: Garpho
# Description: A script to cook


# Sourcing DRYa Lib 2
   v_lib2=${v_REPOS_CENTER}/DRYa/all/lib/drya-lib-2-tmp-n-config-files.sh
   [[ -f $v_lib2 ]] && source $v_lib2 || read -s -n 1 -p "Error: drya-lib-2 does not exist"

   # Example: f_create_tmp_file will create a temporary file stored at $v_tmp (with abs path, at ~/.tmp/...)


function f_menu_receitas {

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='ga receitas'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. Editar | Boilerplate (para novas receita)'
      L5='5. Criar  | Nova Receita (com boilerplate)'
      L4='4. Abrir  | Livros de Receitas (em PDF)'
      L3='3. Marcar | Receitas (guardar lista tmp de receitas)'                                      
      L2='2. Ler    | uma Receita texto'                                      
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
   # Ordem de Saida das opcoes durante run-time
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n\n$Lz3" | fzf --no-info --pointer=">" --cycle --prompt="$L0")

   # Atualizar historico fzf automaticamente (deste menu)
      echo "$Lz2" >> $Lz4
   
   # Atuar de acordo com as instrucoes introduzidas pelo utilizador
      [[   $v_list =~ $Lz3  ]] && echo -e "Acede ao historico com \`D ..\` e encontra: \n > $Lz2"
      [[   $v_list =~ "6. " ]] && vim ${v_REPOS_CENTER}/garpho/all/etc/boilerplate-receita-nova.txt
      [[   $v_list =~ "5. " ]] && f_criar_nova_receita_com_boilerplate
      [[   $v_list =~ "4. " ]] && v_livro=$(ls ${v_REPOS_CENTER}/garpho/all/receitas/pdf | fzf ) && echo "vai ser aberto: $v_livro" && xdg-open ${v_REPOS_CENTER}/garpho/all/receitas/pdf/$v_livro
      [[   $v_list =~ "3. " ]] && echo "uDev"
      [[   $v_list =~ "2. " ]] && v_file=$(ls ${v_REPOS_CENTER}/garpho/all/receitas/texto | fzf) && less ${v_REPOS_CENTER}/garpho/all/receitas/texto/$v_file
      [[   $v_list =~ "1. " ]] && echo "Canceled" 
      unset v_list

}
    
function f_criar_nova_receita_com_boilerplate { 
   # Usa drya-lib-2 e boilerplate-receita-nova.txt para criar uma nova receita do zero 

   # Criar dois novos ficheiroz (com lib)
      f_create_tmp_file 
      v_tmp1=$v_tmp

      sleep 1  # Serve para que ambos os ficheiros tenham nomes diferentes, porque o nome temporario é baseado na hora atual

      f_create_tmp_file 
      v_tmp2=$v_tmp
         
   # Caminho do boilerplate modelo
      v_boi=${v_REPOS_CENTER}/garpho/all/etc/boilerplate-receita-nova.txt

   # Caminho do diretorio onde vai ser guardado o ficheiro da receita
      v_path=${v_REPOS_CENTER}/garpho/all/receitas/texto

   # Decidir o nome da receita
      echo    "Qual o nome que quer dar a receita? "
      read -p " > " v_name
      echo
         
      v_name_underscored=$(sed 's/ /_/g' <(echo $v_name))  # Nome do ficheiro, os espacos " " foram substituidos por underscores "_"
      v_name_title="# Title: $v_name"   

   # Caminho final do ficheiro
      v_perm=$v_path/$v_name_underscored

   # Substituir o texto do ficheiro temporario pelo texto do boilerplate
      cat $v_boi > $v_tmp1

   # Substituir o titulo do documento (dentro do documento)
      sed -i "/Title/d" $v_tmp1

   # Criar "# Title" no segundo ficheiro temporario
     echo "$v_name_title" > $v_tmp2

   # Combinar ambos os ficheiros temporarios
      cat $v_tmp1 >> $v_tmp2

   # Concluir. Mover e renomear o ficheiro temporario
      rv  $v_tmp1 
      mv  $v_tmp2 $v_perm

   # Editar ficheiro final, para inserir a receita
      vim $v_perm
}


function f_filtrar_hashtags {

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='ga hash'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L8='8. #tempo[-de30min] ' 
      L7='7. #tempo[+de30min] ' 

      L6='6. #forno ' 
      L5='5. #batidos ' 
      L4='4. #bolos' 
      L3='3. #yammy-n' 
      L2='2. #yammy-s' 
      L1='1. Cancel'

      L0="garpho: Menu Hashtags: SELECT (1 ou +): "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$Lz3" | fzf -m --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "8. " ]] && echo "uDev"
      [[ $v_list =~ "7. " ]] && echo "uDev"
      [[ $v_list =~ "6. " ]] && echo "uDev"
      [[ $v_list =~ "5. " ]] && echo "uDev"
      [[ $v_list =~ "4. " ]] && echo "uDev"
      [[ $v_list =~ "3. " ]] && echo "uDev"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2"
      unset v_list
}
    


function f_menu_lista_de_compras {
   # Gerir e criar listas de compras
      
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='ga menu-compras'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L11='11. Script | multi cronometros | `D ca`'

      L10='10. Agendar: Lista de Compras nova:'
       L9='9.  Lista  | 1 | Nova Wish list      | Criar nova  (de 0 para 3)'
       L8='8.  Lista  | 2 | Adicionar + Wish    | (de 0 para 3)'
       L7='7.  Lista  | 4 | Catalogo Wish'

       L6='6.  Gerir + Criar: Lista do Carrinho de compras'
       L5='5.  Lista | 3 | De: Wish para: Kart |  '
       L4='4.  Lista | 4 | Catalogo Kart'

       L3='3.  Lista | 0 | Catalogo            | So ver: TODOS'
       L2='2.  Ver   | TODOS os ingredientes + Produtos conhecidos'
       L1='1.  Cancel'

       L0="garpho: [1]: menu compras: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --pointer=">" --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" 
      [[ $v_list =~ "11. " ]] && echo "uDev: $L11" 
      [[ $v_list =~ "10. " ]] && echo "uDev: $L10" 
      [[ $v_list =~ "9.  " ]] && echo "uDev: $L9" 
      [[ $v_list =~ "8.  " ]] && echo "uDev: $L8" 
      [[ $v_list =~ "7.  " ]] && echo "uDev: $L7" 
      [[ $v_list =~ "6.  " ]] && echo "uDev: $L6" 
      [[ $v_list =~ "5.  " ]] && echo "uDev: $L5" 
      [[ $v_list =~ "4.  " ]] && echo "uDev: $L4" 
      [[ $v_list =~ "3.  " ]] && echo "uDev: $L3" 
      [[ $v_list =~ "2.  " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2"
      unset v_list
    
}


function f_demonstrar_todos_os_produtos {
   L0="garpho: Lista de todos os ingredientes"

   v_items=$(less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt | fzf --prompt="$L0" -m) && [[ -n $v_items ]] && echo "$v_items" > ${v_REPOS_CENTER}/garpho/all/lista-de-compras/1-wish-list.txt

   [[ -n $v_items ]] && echo $v_items
}

function f_menu_principal {
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Saved '; Lz2='ga'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

       L8='8. Menu | Agricultura'    # quando plantar X planta
       L7='7. web  | Culinaria Ayurvedica (Aki Sinta Saude)'

       L6='6. Menu | multi cronometros | `D ca`'  # Dolce Gusto Mimic Times (Esta em ca-lculadoras
       L5='5. Menu | Agendar/Gerir Compras'

       L4='4. Ver  | Todos os ingredientes + Produtos conhecidos'
       L3='3. Menu | Receitas'
       L2='2. Menu | Hashtags'

       L1='1. Cancel'

       L0="garpho: main menu: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n\n$L7 \n$L8 \n\n$Lz3" | fzf --no-info --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
      [[ $v_list =~ "8. " ]] && echo "uDev: $L10"
      [[ $v_list =~ "7. " ]] && xdg-open https://akisintasaude.pt 
      [[ $v_list =~ "6. " ]] && echo "uDev: $L7"
      [[ $v_list =~ "5. " ]] && f_menu_lista_de_compras
      [[ $v_list =~ "4. " ]] && f_demonstrar_todos_os_produtos
      [[ $v_list =~ "3. " ]] && f_menu_receitas
      [[ $v_list =~ "2. " ]] && f_filtrar_hashtags
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
}



if [ -z $1 ]; then
   # Se nao for apresentado nenhum argumento, apresentar o menu principal
   f_menu_principal

elif [ $1 == "menu-compras" ] || [ $1 == "c" ]; then
   # Aprentar o menu de lista de compras diretamente
   f_menu_lista_de_compras


elif [ $1 == "hash" ] || [ $1 == "H" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags

elif [ $1 == "receitas" ] || [ $1 == "r" ]; then
   if [ -z $2 ]; then
      f_menu_receitas

   elif [ $2 == "nova" ] || [ $2 == "n" ]; then
      f_criar_nova_receita_com_boilerplate 
   fi
fi
