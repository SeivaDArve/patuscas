# Title: Garpho
# Description: A script to cook




function f_menu_2 {
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='garpho'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L11='11. Help: Como escrever uma receita neste script'

      L10='10. Go site   | Culinaria Ayurvedica (Aki Sinta Saude)'

       L9='9.  Script    | multi cronometros | `D ca`'

       L8='8.  Lista de compras | Criar nova '
       L7='7.  Lista de compras | Ver e mover (mover para "adquiridos")'
       L6='6.  Lista de compras | Ver "adquiridos"'

       L5='5.  Marcar receitas (para ToDo list)' 

       L4='4.  Ver:  Todos os ingredientes + produtos'
       L3='3.  Ver:  Todas as receitas'
       L2='2.  Ver:  Todos os Hashtag'

       L1='1. Cancel'

       L0="garpho: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n\n$L6 \n$L7 \n$L8 \n\n$L9 \n$L10 \n\n$L11 \n\n$Lz3" | fzf --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2" 
      [[ $v_list =~ "11. " ]] && echo "uDev: $L11"
      [[ $v_list =~ "10. " ]] && xdg-open https://akisintasaude.pt 
      [[ $v_list =~ "9.  " ]] && echo "uDev: $L9"
      [[ $v_list =~ "8.  " ]] && v_items=$(less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt | fzf -m) && [[ -n $v_items ]] && echo "$v_items" > ${v_REPOS_CENTER}/garpho/all/lista-de-compras/1-wish-list.txt
      [[ $v_list =~ "7.  " ]] && echo "uDev: $L7"
      [[ $v_list =~ "6.  " ]] && echo "uDev: $L6"
      [[ $v_list =~ "5.  " ]] && echo "uDev: $L5"
      [[ $v_list =~ "4.  " ]] && less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt
      [[ $v_list =~ "3.  " ]] && v_file=$(ls ${v_REPOS_CENTER}/garpho/all/receitas/texto/ | fzf) && less ${v_REPOS_CENTER}/garpho/all/receitas/texto/$v_file
      [[ $v_list =~ "2.  " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}
    

function f_filtrar_hashtags {

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L7='7. #forno ' 
      L6='6. #batidos ' 
      L5='5. #bolos' 
      L4='4. #yammy-n' 
      L3='3. #yammy-s' 
      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf -m --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2" && sleep 0.1 
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
}
    


function f_menu_lista_de_compras {
   # Gerir e criar listas de compras
      
   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

       L9='9.  Script    | multi cronometros | `D ca`'

       L4='4.  Lista de TODOS os ingredientes + Produtos conhecidos:'

       L4='4.  Gerir + Criar: Lista de Compras nova:'
       L8='8.  Lista | 1 | Nova Wish list      | Criar nova  (de 0 para 3)'
       L7='7.  Lista | 2 | Adicionar + Wish    | (de 0 para 3)'
       L6='6.  Lista | 4 | Catalogo Wish'

       L4='4.  Gerir + Criar: Lista do Carrinho de compras'
       L7='7.  Lista | 3 | De: Wish para: Kart |     ()'
       L6='6.  Lista | 4 | Catalogo Kart'

       L4='4.  Lista | 0 | Catalogo            | So ver: TODOS'
       L4='4.  Ver  | TODOS os ingredientes + Produtos conhecidos'
       L1='1.  Cancel'

       L0="garpho: agendar compras: "
      
      v_list=$(echo -e "$L1 \n$L2 \n$L3 \n$L4 \n\n$Lz3" | fzf --layout=reverse-list --pointer=">" --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "4. " ]] && f_pin && echo "uDev: $L4"
      [[ $v_list =~ "3. " ]] && echo "uDev: $L3" && history -s "$L3c" 
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2" && sleep 0.1 
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
}





function f_menu_principal {
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='garpho'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      # Dolce Gusto Mimic Times (Esta em ca-lculadoras
      #L11='11. Agricultura: quando plantar X planta
      L11='11. Help | Como escrever uma receita neste script'

      L10='10. Web  | Culinaria Ayurvedica (Aki Sinta Saude)'

       L9='9.  Menu | multi cronometros | `D ca`' 

       L6='6.  Menu | Agendar compras'
       L5='5.  Menu | Agendar receitas' 

       L4='4.  Ver  | TODOS os ingredientes + Produtos conhecidos'
       L3='3.  Ver  | Todas as receitas'
       L2='2.  Ver  | Todos os Hashtag'
       L2="2.  Ver  $FZF_TOTAL_COUNT"

       L1='1. Cancel'

       L0="garpho: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n\n$L6 \n$L7 \n$L8 \n\n$L9 \n$L10 \n\n$L11 \n\n$Lz3" | fzf --layout=reverse-list --reverse --cycle --prompt="$L0")

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3   ]] && echo "$Lz2" && history -s "$Lz2" 
      [[ $v_list =~ "11. " ]] && echo "uDev: $L11"
      [[ $v_list =~ "10. " ]] && xdg-open https://akisintasaude.pt 
      [[ $v_list =~ "9.  " ]] && echo "uDev: $L9"
      [[ $v_list =~ "8.  " ]] && v_items=$(less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt | fzf -m) && [[ -n $v_items ]] && echo "$v_items" > ${v_REPOS_CENTER}/garpho/all/lista-de-compras/1-wish-list.txt
      [[ $v_list =~ "7.  " ]] && echo "uDev: $L7"
      [[ $v_list =~ "6.  " ]] && echo "uDev: $L6"
      [[ $v_list =~ "5.  " ]] && echo "uDev: $L5"
      [[ $v_list =~ "4.  " ]] && less ${v_REPOS_CENTER}/garpho/all/ingredientes/all-ingredientes.txt
      [[ $v_list =~ "3.  " ]] && v_file=$(ls ${v_REPOS_CENTER}/garpho/all/receitas/texto/ | fzf) && less ${v_REPOS_CENTER}/garpho/all/receitas/$v_file
      [[ $v_list =~ "2.  " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    
}

# uDev: Mesclar os 2 menus
   f_menu_principal
   f_menu_2
