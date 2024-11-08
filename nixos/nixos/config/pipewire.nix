{ pkgs, ... }:
{
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  wireplumber.enable = true;

# # Rnnoise
# extraConfig = ''
# context.modules = [
# {   name = libpipewire-module-filter-chain
#     args = {
#         node.description =  "Noise Canceling source"
#         media.name =  "Noise Canceling source"
#         filter.graph = {
#             nodes = [
#                 {
#                     type = ladspa
#                     name = rnnoise
#                     plugin = /path/to/librnnoise_ladspa.so
#                     label = noise_suppressor_mono
#                     control = {
#                         "VAD Threshold (%)" = 50.0
#                         "VAD Grace Period (ms)" = 200
#                         "Retroactive VAD Grace (ms)" = 0
#                     }
#                 }
#             ]
#         }
#         capture.props = {
#             node.name =  "capture.rnnoise_source"
#             node.passive = true
#             audio.rate = 48000
#         }
#         playback.props = {
#             node.name =  "rnnoise_source"
#             media.class = Audio/Source
#             audio.rate = 48000
#         }
#     }
# }
# ]
#     '';
};
# environment.systemPackages = with pkgs; [
# pipewire
# (pkgs.callPackage (pkgs.fetchFromGitHub {
#   owner = "werman";
#   repo = "noise-suppression-for-voice";
#   rev = "v1.10";  # or a specific release tag
#   sha256 = "13xmw4n9i2a0ib8aq92r1aj4m7iyxd18rhz338l35n35j5vhgz5i";
# }) {})
# ];
}






