# 🌿 Labyrinth

Discover Labyrinth, a serene color scheme inspired by hidden pathways and mossy landscapes. Let its gentle tones guide your creativity with calm elegance.

Labyrinth provides four distinct variants with varying levels of contrast and color vibrancy to suit your preferences:

 - **Gloom**: The most contrasty variant, perfect for those who prefer sharp distinctions and vibrant colors.
 - **Dusk**: A balanced variant, offering a comfortable middle ground with moderate contrast and vibrancy.
 - **Shade**: A softer variant with reduced contrast, ideal for a more subdued and relaxed visual experience.
 - **Mist**: The least contrasty variant, featuring the most gentle and subtle tones for a calm and unobtrusive interface.

Whether you're coding, designing, or simply exploring new aesthetics, Labyrinth adapts to your needs with its harmonious palette.

## Usage

> [!IMPORTANT]
> It uses a [Nerdfont](https://www.nerdfonts.com/font-downloads) by default for the icons, so it is recommended to have a Nerdfont set as your terminal font

**Tmux Plugin Manager**

1. Install [TPM](https://github.com/tmux-plugins/tpm)
<br>

2. Add the Labyrinth plugin with the following lines:

```bash
set -g @plugin 'dgabka/labyrinth-tmux'
# ... alongside
set -g @plugin 'tmux-plugins/tpm'
```
<br>

**Nix Home Manager**

```nix
let
  labyrinth-tmux =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "labyrinth-tmux";
      version = "unstable-2024-01-08";
      rtpFilePath = "labyrinth.tmux";
      src = pkgs.fetchFromGitHub {
        owner = "dgabka";
        repo = "labyrinth-tmux";
        rev = "0bcab8a07abdf8d5c56898f0b5c21d741e137ffd";
        sha256 = "sha256-bvC42ctPyo2o2h5Muh7aHwHhDYb3MOlDEdrVqt+dH74=";
      };
    };
in {
    programs.tmux.plugins = with pkgs; [
    {
      plugin = labyrinth-tmux;
      extraConfig = ''...''
    }
  ];

}
```

**Configuration**

Add these entries either directly in your `.tmux.conf` or `extraConfig` section of tmux plugin

Set your preferred variant:

```bash
set -g @labyrinth_variant 'main' # Options are 'main', 'moon' or 'dawn'
```

Activate the extra modules, they are enabled by writing 'on' after the option name
```bash
set -g @labyrinth_host 'on' # Enables hostname in the status bar
set -g @labyrinth_date_time '' # It accepts the date UNIX command format (man date for info)
set -g @labyrinth_user 'on' # Turn on the username component in the statusbar
set -g @labyrinth_directory 'on' # Turn on the current folder component in the status bar
set -g @labyrinth_bar_bg_disable 'on' # Disables background color, for transparent terminal emulators
# If @labyrinth_bar_bg_disable is set to 'on', uses the provided value to set the background color
# It can be any of the on tmux (named colors, 256-color set, `default` or hex colors)
# See more on http://man.openbsd.org/OpenBSD-current/man1/tmux.1#STYLES
set -g @labyrinth_bar_bg_disabled_color_option 'default'

set -g @labyrinth_only_windows 'on' # Leaves only the window module, for max focus and space
set -g @labyrinth_disable_active_window_menu 'on' # Disables the menu that shows the active window on the left

set -g @labyrinth_default_window_behavior 'on' # Forces tmux default window list behaviour
set -g @labyrinth_show_current_program 'on' # Forces tmux to show the current running program as window name
set -g @labyrinth_show_pane_directory 'on' # Forces tmux to show the current directory as window name
# Previously set -g @labyrinth_window_tabs_enabled

# Example values for these can be:
set -g @labyrinth_left_separator ' > ' # The strings to use as separators are 1-space padded
set -g @labyrinth_right_separator ' < ' # Accepts both normal chars & nerdfont icons
set -g @labyrinth_field_separator ' | ' # Again, 1-space padding, it updates with prefix + I
set -g @labyrinth_window_separator ' - ' # Replaces the default `:` between the window number and name

# These are not padded
set -g @labyrinth_session_icon '' # Changes the default icon to the left of the session name
set -g @labyrinth_current_window_icon '' # Changes the default icon to the left of the active window name
set -g @labyrinth_folder_icon '' # Changes the default icon to the left of the current directory folder
set -g @labyrinth_username_icon '' # Changes the default icon to the right of the hostname
set -g @labyrinth_hostname_icon '󰒋' # Changes the default icon to the right of the hostname
set -g @labyrinth_date_time_icon '󰃰' # Changes the default icon to the right of the date module
set -g @labyrinth_window_status_separator "  " # Changes the default icon that appears between window names

# Very beta and specific opt-in settings, tested on v3.2a, look at issue #10
set -g @labyrinth_prioritize_windows 'on' # Disables the right side functionality in a certain window count / terminal width
set -g @labyrinth_width_to_hide '80' # Specify a terminal width to toggle off most of the right side functionality
set -g @labyrinth_window_count '5' # Specify a number of windows, if there are more than the number, do the same as width_to_hide
```
- The separator options should go back to the defaults ( →, ← and | NerdFont characters) if the options are unset and you close all tmux sessions (a full restart)
- The `@labyrinth_width_to_hide` and `labyrinth_window_count` settings do not refresh automatically. They need to be refreshed manually, their current state is discussed [here](https://github.com/rose-pine/tmux/issues/10).
- For `@labyrinth_window_tabs_enabled` and any further naming changes / notices, see issue #14.

6. Integration with other status-bar plugins
- You can add, for example, the [tmux-mode-indicator](https://github.com/MunifTanjim/tmux-mode-indicator) plugin:
```bash
# Add to the beginning / end of the left and right sections your own.
set -g @labyrinth_status_left_prepend_section '#{tmux_mode_indicator}'
set -g @labyrinth_status_left_append_section 'It works'
set -g @labyrinth_status_right_prepend_section 'with normal text'
set -g @labyrinth_status_right_append_section 'too'
```

## Gallery

#### TODO

### Credits

Thanks to the [Rosé Pine](https://github.com/rose-pine) creators!
A special thanks to [Rosé Pine for tmux](https://github.com/rose-pine/tmux) which this theme is based on.

