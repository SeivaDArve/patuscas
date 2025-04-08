# Title: Garpho
# Description: A script to cook






# [fzf menu exemplo 1]
   # Menu Simples

   # Lista de opcoes para o menu `fzf`
      Lz1='Save '; Lz2='<menu-terminal-command-here>'; Lz3="$Lz1\`$Lz2\`"; Lz4=$v_drya_fzf_menu_hist

      L8='8. Go site   | Culinaria Ayurvedica (Aki Sinta Saude)'
      L7='7. script    | multi cronometros | `D ca`'
      L6='6. Filtrar 1 | tmp | Lista de compras'
      L5='5. Filtrar 1 | tmp | n receitas'

      L4='4. Help: Como escrever uma receita neste script'
      L3='3. Ver:  Todas as receitas'
      L2='2. Ver:  Todos os Hashtag'

      L1='1. Cancel'

      L0="SELECT 1: Menu X: "
      
      v_list=$(echo -e "$L1 \n\n$L2 \n$L3 \n$L4 \n\n$L5 \n$L6 \n$L7 \n$L8 \n\n$Lz3" | fzf --cycle --prompt="$L0")

      #echo "comando" >> ~/.bash_history && history -n
      #history -s "echo 'Olá, mundo!'"

   # Perceber qual foi a escolha da lista
      [[ $v_list =~ $Lz3  ]] && echo "$Lz2" && history -s "$Lz2"
      [[ $v_list =~ "8. " ]] && echo "uDev: $L8"
      [[ $v_list =~ "7. " ]] && echo "uDev: $L7"
      [[ $v_list =~ "6. " ]] && echo "uDev: $L6"
      [[ $v_list =~ "5. " ]] && echo "uDev: $L5"
      [[ $v_list =~ "4. " ]] && echo "uDev: $L4"
      [[ $v_list =~ "3. " ]] && echo "uDev: $L3"
      [[ $v_list =~ "2. " ]] && echo "uDev: $L2"
      [[ $v_list =~ "1. " ]] && echo "Canceled: $Lz2" && history -s "$Lz2"
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
    



