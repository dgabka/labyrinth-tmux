#!/usr/bin/env bash
#
# Labyrinth - tmux theme
#
# Inspired by rose-pine/tmux
#
#
export TMUX_LABYRINTH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"

    if [ -n "$value" ]; then
        echo "$value"
    else
        echo "$default"
    fi
}

set() {
    local option=$1
    local value=$2
    tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
    local option=$1
    local value=$2
    tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

unset_option() {
    local option=$1
    local value=$2
    tmux_commands+=(set-option -gu "$option" ";")
}

main() {
    local theme
    theme="$(get_tmux_option "@labyrinth_variant" "dusk")"

    # INFO: Not removing the thm_hl_low and thm_hl_med colors for posible features
    # INFO: If some variables appear unused, they are being used either externally
    # or in the plugin's features
    if [[ $theme == gloom ]]; then

        thm_base="#10141b"
        thm_surface="#161b24"
        thm_overlay="#1d2230"
        thm_muted="#4c5765"
        thm_subtle="#6e7b8b"
        thm_text="#d3d8e2"
        thm_crimson="#c94f6d"
        thm_sun="#d99a5c"
        thm_amber="#da877f"
        thm_moss="#3b7968"
        thm_leaf="#8fa8a0"
        thm_haze="#8e7aa8"
        thm_hl_low="#202738"
        thm_hl_med="#3a4258"
        thm_hl_high="#505b72"

    elif [[ $theme == dusk ]]; then

        thm_base="#181b24"
        thm_surface="#1e222d"
        thm_overlay="#242834"
        thm_muted="#575e72"
        thm_subtle="#7a8194"
        thm_text="#dee1eb"
        thm_crimson="#d7617b"
        thm_sun="#e0a469"
        thm_amber="#e2968b"
        thm_moss="#458976"
        thm_leaf="#99b2a8"
        thm_haze="#9884b2"
        thm_hl_low="#282d3c"
        thm_hl_med="#434a62"
        thm_hl_high="#596579"

    elif [[ $theme == shade ]]; then
        thm_base="#1c1f29"
        thm_surface="#222732"
        thm_overlay="#282d39"
        thm_muted="#646a7c"
        thm_subtle="#8a91a3"
        thm_text="#c4c7d4"
        thm_crimson="#b15366"
        thm_sun="#c88b59"
        thm_amber="#c88b7a"
        thm_moss="#387464"
        thm_leaf="#82a0a0"
        thm_haze="#827398"
        thm_hl_low="#2e3343"
        thm_hl_med="#4a5167"
        thm_hl_high="#5f6a7d"

    elif [[ $theme == mist ]]; then
        thm_base="#20232b"
        thm_surface="#262933"
        thm_overlay="#2c2f39"
        thm_muted="#707785"
        thm_subtle="#8e95a5"
        thm_text="#b0b3bf"
        thm_crimson="#9a4856"
        thm_sun="#ae7b4d"
        thm_amber="#ae7b6a"
        thm_moss="#2f5e52"
        thm_leaf="#6c8a8a"
        thm_haze="#6c5f7f"
        thm_hl_low="#343a4c"
        thm_hl_med="#565d75"
        thm_hl_high="#717a8f"
    fi

    # Aggregating all commands into a single array
    local tmux_commands=()

    # Status bar
    set "status" "on"
    set status-style "fg=$thm_moss,bg=$thm_base"
    # set monitor-activity "on"
    # Leave justify option to user
    # set status-justify "left"
    set status-left-length "200"
    set status-right-length "200"

    # Theoretically messages (need to figure out color placement)
    set message-style "fg=$thm_muted,bg=$thm_base"
    set message-command-style "fg=$thm_base,bg=$thm_sun"

    # Pane styling
    set pane-border-style "fg=$thm_hl_high"
    set pane-active-border-style "fg=$thm_sun"
    set display-panes-active-colour "${thm_text}"
    set display-panes-colour "${thm_sun}"

    # Windows
    setw window-status-style "fg=${thm_haze},bg=${thm_base}"
    setw window-status-activity-style "fg=${thm_base},bg=${thm_amber}"
    setw window-status-current-style "fg=${thm_sun},bg=${thm_base}"

    # Statusline base command configuration: No need to touch anything here
    # Placement is handled below

    # Shows username of the user the tmux session is run by
    local user
    user="$(get_tmux_option "@labyrinth_user" "")"
    readonly user

    # Shows hostname of the computer the tmux session is run on
    local host
    host="$(get_tmux_option "@labyrinth_host" "")"
    readonly host

    # Date and time command: follows the date UNIX command structure
    local date_time
    date_time="$(get_tmux_option "@labyrinth_date_time" "")"
    readonly date_time

    # Shows truncated current working directory
    local directory
    directory="$(get_tmux_option "@labyrinth_directory" "")"

    local disable_active_window_menu
    disable_active_window_menu="$(get_tmux_option "@labyrinth_disable_active_window_menu" "")"

    local show_current_program
    show_current_program="$(get_tmux_option "@labyrinth_show_current_program" "")"
    readonly show_current_program

    local window_directory
    window_directory="$(get_tmux_option "@labyrinth_show_pane_directory" "")"
    readonly window_directory

    local window_separator
    window_separator="$(get_tmux_option "@labyrinth_window_separator" "")"
    readonly window_separator

    local default_window_behavior
    default_window_behavior="$(get_tmux_option "@labyrinth_default_window_behavior" "")"
    readonly default_window_behavior

    # Changes the background color for the current active window
    # TODO: Together with line 251-269, end development for this feature
    # local active_window_color
    # active_window_color="$(get_tmux_option "@labyrinth_active_window_color" "")"
    # readonly active_window_color

    # Transparency enabling for status bar
    local bar_bg_disable
    bar_bg_disable="$(get_tmux_option "@labyrinth_bar_bg_disable" "")"
    readonly bar_bg_disable

    # Transparent option for status bar
    local bar_bg_disabled_color_option
    bar_bg_disabled_color_option="$(get_tmux_option "@labyrinth_bar_bg_disabled_color_option" "0")"
    readonly bar_bg_disabled_color_option

    # Shows hostname of the computer the tmux session is run on
    local only_windows
    only_windows="$(get_tmux_option "@labyrinth_only_windows" "")"
    readonly only_windows

    # Allows user to set a few custom sections (for integration with other plugins)
    # Before the plugin's left section
    local status_left_prepend_section
    status_left_prepend_section="$(get_tmux_option "@labyrinth_status_left_prepend_section" "")"
    readonly status_left_prepend_section
    #
    # after the plugin's left section
    local status_left_append_section
    status_left_append_section="$(get_tmux_option "@labyrinth_status_left_append_section" "")"
    readonly status_left_append_section
    # Before the plugin's right section
    local status_right_prepend_section
    status_right_prepend_section="$(get_tmux_option "@labyrinth_status_right_prepend_section" "")"
    readonly status_right_prepend_section
    #
    # after the plugin's right section
    local status_right_append_section
    status_right_append_section="$(get_tmux_option "@labyrinth_status_right_append_section" "")"
    readonly status_right_append_section

    # Settings that allow user to choose their own icons and status bar behaviour
    # START
    local current_window_icon
    current_window_icon="$(get_tmux_option "@labyrinth_current_window_icon" "")"
    readonly current_window_icon

    local current_session_icon
    current_session_icon="$(get_tmux_option "@labyrinth_session_icon" "")"
    readonly current_session_icon

    local username_icon
    username_icon="$(get_tmux_option "@labyrinth_username_icon" "")"
    readonly username_icon

    local hostname_icon
    hostname_icon="$(get_tmux_option "@labyrinth_hostname_icon" "󰒋")"
    readonly hostname_icon

    local date_time_icon
    date_time_icon="$(get_tmux_option "@labyrinth_date_time_icon" "󰃰")"
    readonly date_time_icon

    local current_folder_icon
    current_folder_icon="$(get_tmux_option "@labyrinth_folder_icon" "")"
    readonly current_folder_icon

    # Changes the icon / character that goes between each window's name in the bar
    local window_status_separator
    window_status_separator="$(get_tmux_option "@labyrinth_window_status_separator" "  ")"

    # This setting does nothing by itself, it enables the 2 below it to toggle the simplified bar
    local prioritize_windows
    prioritize_windows="$(get_tmux_option "@labyrinth_prioritize_windows" "")"

    # Allows the user to set a min width at which most of the bar elements hide, or
    local user_window_width
    user_window_width="$(get_tmux_option "@labyrinth_width_to_hide" "")"

    # A number of windows, when over it, the bar gets simplified
    local user_window_count
    user_window_count="$(get_tmux_option "@labyrinth_window_count" "")"

    # Custom window status that goes between the number and the window name
    local custom_window_sep="#[fg=$thm_haze]#I#[fg=$thm_haze,]$window_separator#[fg=$thm_haze]#W"
    local custom_window_sep_current="#I#[fg=$thm_sun,bg=""]$window_separator#[fg=$thm_sun,bg=""]#W"

    local right_separator
    right_separator="$(get_tmux_option "@labyrinth_right_separator" "  ")"

    local left_separator
    left_separator="$(get_tmux_option "@labyrinth_left_separator" "  ")"

    local field_separator
    # NOTE: Don't remove
    field_separator="$(get_tmux_option "@labyrinth_field_separator" " | ")"

    # END

    local spacer
    spacer=" "
    # I know, stupid, right? For some reason, spaces aren't consistent

    # These variables are the defaults so that the setw and set calls are easier to parse

    local show_window
    readonly show_window=" #[fg=$thm_subtle]$current_window_icon #[fg=$thm_amber]#W$spacer"

    local show_window_in_window_status
    show_window_in_window_status="#[fg=$thm_haze]#I#[fg=$thm_haze,]$left_separator#[fg=$thm_haze]#W"

    local show_window_in_window_status_current
    show_window_in_window_status_current="#I#[fg=$thm_sun,bg=""]$left_separator#[fg=$thm_sun,bg=""]#W"

    local show_session
    readonly show_session=" #[fg=$thm_text]$current_session_icon #[fg=$thm_text]#S "

    local show_user
    readonly show_user="#[fg=$thm_haze]#(whoami)#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]$username_icon"

    local show_host
    readonly show_host="$spacer#[fg=$thm_text]#H#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]$hostname_icon"

    local show_date_time
    readonly show_date_time=" #[fg=$thm_leaf]$date_time#[fg=$thm_subtle]$right_separator#[fg=$thm_subtle]$date_time_icon "

    local show_directory
    readonly show_directory="$spacer#[fg=$thm_subtle]$current_folder_icon #[fg=$thm_amber]#{b:pane_current_path} "

    local show_directory_in_window_status
    # BUG: It doesn't let the user pass through a custom window name
    show_directory_in_window_status="#I$left_separator#[fg=$thm_sun,bg=""]#{b:pane_current_path}"

    local show_directory_in_window_status_current
    show_directory_in_window_status_current="#I$left_separator#[fg=$thm_sun,bg=""]#{b:pane_current_path}"

    # TODO: This needs some work and testing, rn I can't figure it out
    # if [[ "$active_window_color" == "crimson" ]]; then
    #     show_window_in_window_status_current="#[bg=$thm_crimson,bg=$thm_base]#I$left_separator#W"
    # fi
    # if [[ "$active_window_color" == "sun" ]]; then
    #     show_window_in_window_status_current="#[bg=$thm_sun,bg=$thm_base]#I$left_separator#W"
    # fi
    # if [[ "$active_window_color" == "amber" ]]; then
    #     show_window_in_window_status_current="#bg=$thm_amber,bg=$thm_base#I$left_separator#W"
    # fi
    # if [[ "$active_window_color" == "moss" ]]; then
    #     show_window_in_window_status_current="#[bg=$thm_moss,bg=$thm_base]#I$left_separator#W"
    # fi
    # if [[ "$active_window_color" == "leaf" ]]; then
    #     show_window_in_window_status_current="#[bg=$thm_leaf,bg=$thm_base]#I$left_separator#W"
    # fi
    # if [[ "$active_window_color" == "haze" ]]; then
    #     show_window_in_window_status_current="#[bg=$thm_haze,bg=$thm_base]#I$left_separator#W"
    # fi

    # Left status: Now moved to a variable called left_column
    # (we can append / prepend things to it)
    local left_column

    # Right status and organization:
    # Right status shows nothing by default
    local right_column

    # This if statement allows the bg colors to be null if the user decides so
    # It sets the base colors for active / inactive, no matter the window appearence switcher choice
    # TEST: This needs to be tested further
    if [[ "$bar_bg_disable" == "on" ]]; then
        set status-style "fg=$thm_moss,bg=$bar_bg_disabled_color_option"
        show_window_in_window_status="#[fg=$thm_haze,bg=$bar_bg_disabled_color_option]#I#[fg=$thm_haze,bg=$bar_bg_disabled_color_option]$left_separator#[fg=$thm_haze,bg=$bar_bg_disabled_color_option]#W"
        show_window_in_window_status_current="#[fg=$thm_sun,bg=$bar_bg_disabled_color_option]#I#[fg=$thm_sun,bg=$bar_bg_disabled_color_option]$left_separator#[fg=$thm_sun,bg=$bar_bg_disabled_color_option]#W"
        show_directory_in_window_status="#[fg=$thm_haze,bg=$bar_bg_disabled_color_option]#I#[fg=$thm_haze,bg=$bar_bg_disabled_color_option]$left_separator#[fg=$thm_haze,bg=$bar_bg_disabled_color_option]#{b:pane_current_path}"
        show_directory_in_window_status_current="#[fg=$thm_sun,bg=$bar_bg_disabled_color_option]#I#[fg=$thm_sun,bg=$bar_bg_disabled_color_option]$left_separator#[fg=$thm_sun,bg=$bar_bg_disabled_color_option]#{b:pane_current_path}"
        set window-status-style "fg=$thm_haze,bg=$bar_bg_disabled_color_option"
        set window-status-current-style "fg=$thm_sun,bg=$bar_bg_disabled_color_option"
        set window-status-activity-style "fg=$thm_amber,bg=$bar_bg_disabled_color_option"
        set message-style "fg=$thm_muted,bg=$bar_bg_disabled_color_option"
    fi

    # Window appearence switcher: 3 options for the user
    if [[ "$window_separator" != "" ]]; then
        window_status_format=$custom_window_sep
        window_status_current_format=$custom_window_sep_current
        setw window-status-format "$window_status_format"
        setw window-status-current-format "$window_status_current_format"

    elif [[ "$show_current_program" == "on" ]]; then
        window_status_format=$show_window_in_window_status
        window_status_current_format=$show_window_in_window_status_current
        setw window-status-format "$window_status_format"
        setw window-status-current-format "$window_status_current_format"
    # See line 268
    elif [[ "$window_directory" ]]; then
        local window_status_format=$show_directory_in_window_status
        local window_status_current_format=$show_directory_in_window_status_current
        setw window-status-format "$window_status_format"
        setw window-status-current-format "$window_status_current_format"
        #
    # Base behaviour, but whit cool colors
    elif [[ "$default_window_behavior" == "on" || "$default_window_behavior" == "" ]]; then
        unset_option window-status-format
        unset_option window-status-current-format
    fi

    if [[ "$user" == "on" ]]; then
        right_column=$right_column$show_user
    fi

    if [[ "$host" == "on" ]]; then
        right_column=$right_column$show_host
    fi

    if [[ "$date_time" != "" ]]; then
        right_column=$right_column$show_date_time
    fi

    if [[ "$directory" == "on" ]]; then
        right_column=$right_column$show_directory
    fi

    # The append and prepend sections are for inter-plugin compatibility
    # and extension
    if [[ "$disable_active_window_menu" == "on" ]]; then
        left_column=$show_session
    else
        left_column=$show_session$show_window
    fi
    #
    # Appending / Prepending custom user sections to
    if [[ "$status_left_prepend_section" != "" ]]; then
        left_column=$status_left_prepend_section$left_column
    fi
    if [[ "$status_left_append_section" != "" ]]; then
        left_column=$left_column$status_left_append_section$spacer
    fi
    if [[ "$status_right_prepend_section" != "" ]]; then
        right_column=$status_right_prepend_section$right_column
    fi
    if [[ "$status_right_append_section" != "" ]]; then
        right_column=$right_column$status_right_append_section
    fi

    # We set the sections
    set status-left "$left_column"
    set status-right "$right_column"

    # Variable logic for the window prioritization
    local current_window_count
    local current_window_width

    current_window_count=$(tmux list-windows | wc -l)
    current_window_width=$(tmux display -p "#{window_width}")

    # NOTE: Can possibly integrate the $only_windows mode into this
    if [[ "$prioritize_windows" == "on" ]]; then
        if [[ "$current_window_count" -gt "$user_window_count" || "$current_window_width" -lt "$user_window_width" ]]; then
            set status-left "$left_column$show_directory"
            # set status-right "$show_directory"
            set status-right ""
        fi
    else
        set status-right "$right_column"
    fi

    # Defaults to a NerdFont icon, user can change through an option
    if [[ "$window_status_separator" != "  " ]]; then
        setw window-status-separator "$window_status_separator"
    else
        setw window-status-separator "  "
    fi

    # Leaves only the window list on the left side
    if [[ "$only_windows" == "on" ]]; then
        set status-left ""
        set status-right ""
    fi

    # NOTE: Dont remove this, it can be useful for references
    # setw window-status-format "$window_status_format"
    # setw window-status-current-format "$window_status_current_format"

    # tmux integrated modes

    setw clock-mode-colour "${thm_crimson}"
    setw mode-style "fg=${thm_sun}"

    # Call everything to action

    tmux "${tmux_commands[@]}"

}

main "$@"
