# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.223 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.223"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.223/stella-0.9.223-aarch64-apple-darwin.tar.gz"
      sha256 "117764ee113276ed297d2bc49e9875309c588fa82a6f5766920ba57853d2084a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.223/stella-0.9.223-x86_64-apple-darwin.tar.gz"
      sha256 "66448431cd13e2efbeaf2d8839d2b0b1375e225bfd2ec5a242c640e8b161f4bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.223/stella-0.9.223-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "55d6f4863ed70b64cbacfcbbf9233f7868dafb6cb155cc3fff6c2b5efd4cd64b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.223/stella-0.9.223-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99752a242e8f37070f13b36e1c831bf8fcde331d97b65f173c599d4267554ad6"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
