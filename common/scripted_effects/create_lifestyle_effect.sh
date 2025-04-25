#!/bin/bash
# Typically scripts need to be saved without byte order mark (BOM) to be executed correctly

# Get current date in YYYY-MM-DD format
current_date=$(date +%Y-%m-%d)

# Create the output file with BOM
printf '\xEF\xBB\xBF' > tfmagi_clone_lifestyles_vanilla_scripted_effects.txt

# Add date
echo "#generated on $current_date" >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt


echo "" >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt
echo "tfmagi_clone_all_lifestyle_perks = {" >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt

# Process each lifestyle perk
grep -o -h '^[a-z0-9_]*' "$game_lifestyle_perks_dir"/*.txt | while read -r perk; do
    cat >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt << EOF
    if = {
        limit = {
            root = {
                has_perk = $perk
            }
        }
        scope:cloned_character = {
            add_perk = $perk
        }
    }
EOF
done

echo "}" >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt

echo "tfmagi_clone_quarter_vanilla_lifestyle_perks = {" >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt
# Process each lifestyle perk
grep -o -h '^[a-z0-9_]*' "$game_lifestyle_perks_dir"/*.txt | while read -r perk; do
    cat >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt << EOF
    if = {
        limit = {
            root = {
                has_perk = $perk
            }
        }
        scope:cloned_character = {
            random_list = {
                1 = {
                    add_perk = $perk
                }
                3 = {} # nothing
            }
        }
    }
EOF
done

echo "}" >> tfmagi_clone_lifestyles_vanilla_scripted_effects.txt
