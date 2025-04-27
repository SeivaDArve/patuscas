# Title: Garpho
# Description: A script to cook






# [fzf menu exemplo 1]
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
      [[ $v_list =~ "3.  " ]] && v_file=$(ls ${v_REPOS_CENTER}/garpho/all/receitas/texto/ | fzf) && less ${v_REPOS_CENTER}/garpho/all/receitas/$v_file
      [[ $v_list =~ "2.  " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1.  " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
      unset v_list
    

function f_filtrar_hashtags {


# [fzf menu exemplo 1]
   # Menu Simples

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
    



