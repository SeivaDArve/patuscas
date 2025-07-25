# Title: Garpho
# Description: A script to cook




    

function f_filtrar_hashtags {

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='ga hash'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L6='6. #forno ' 
      L5='5. #batidos ' 
      L4='4. #bolos' 
      L3='3. #yammy-n' 
      L2='2. #yammy-s' 
      L1='1. Cancel'

      L0="garpho: Menu Hashtags: SELECT (1 ou +): "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n$L5 \n$L6 \n\n$Lz3" | fzf -m --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" 
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



function f_menu_principal {
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='garpho'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      # Dolce Gusto Mimic Times (Esta em ca-lculadoras
      L10='10. Agricultura'    # quando plantar X planta
       L9='9.  Help | boilerplate (Como escrever uma receita neste script)'
       L8='8.  web  | Culinaria Ayurvedica (Aki Sinta Saude)'
       L7='7.  Menu | multi cronometros | `D ca`' 

       L6='6.  Menu | Agendar/Gerir Compras'
       L5='5.  Menu | Agendar/Gerir Receitas' 

       L4='4.  Ver  | Todos os ingredientes + Produtos conhecidos'
       L3='3.  Ver  | Todas as receitas'
       L2='2.  Ver  | Todos os Hashtag'

       L1='1. Cancel'

       L0="garpho: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n\n$L7 \n$L8 \n$L9 \n$L10 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" 
      [[ $v_list =~ "12. " ]] && echo "uDev: $L12"
      [[ $v_list =~ "11. " ]] && echo "uDev: $L11"
      [[ $v_list =~ "10. " ]] && xdg-open https://akisintasaude.pt 
      [[ $v_list =~ "9.  " ]] && echo "uDev: $L9"
      [[ $v_list =~ "8.  " ]] && v_items=$(less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt | fzf -m) && [[ -n $v_items ]] && echo "$v_items" > ${v_REPOS_CENTER}/garpho/all/lista-de-compras/1-wish-list.txt
      [[ $v_list =~ "7.  " ]] && echo "uDev: $L7"
      [[ $v_list =~ "6.  " ]] && f_menu_lista_de_compras
      [[ $v_list =~ "5.  " ]] && echo "uDev: $L5"
      [[ $v_list =~ "4.  " ]] && less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt
      [[ $v_list =~ "3.  " ]] && v_file=$(ls ${v_REPOS_CENTER}/garpho/all/receitas/texto/ | fzf) && less ${v_REPOS_CENTER}/garpho/all/receitas/$v_file
      [[ $v_list =~ "2.  " ]] && f_filtrar_hashtags
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
}



if [ -z $1 ]; then
   # Se nao for apresentado nenhum argumento, apresentar o menu principal
   f_menu_principal

elif [ $1 == "menu-compras" ] || [ $1 == "c" ]; then
   # Aprentar o menu de lista de compras diretamente
   f_menu_lista_de_compras


elif [ $1 == "hash" ]; then
   # Aprentar o menu de hashtags diretamente
   f_filtrar_hashtags

fi
