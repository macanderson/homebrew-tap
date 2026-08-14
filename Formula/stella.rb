# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.46 / @SHA_*@ placeholders below with
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
  version "0.9.46"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.46/stella-0.9.46-aarch64-apple-darwin.tar.gz"
      sha256 "55f789763ec943a2525a8c4ef046ae059fb5e77be78ca236c82dd98a2d619aa2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.46/stella-0.9.46-x86_64-apple-darwin.tar.gz"
      sha256 "18c0b9e2fa2742777c53d786ace5006a8b150bdaab11909871ffe0bbf590cfd1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.46/stella-0.9.46-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5bc6bac14337f212e05b6e4e268fa023e8bb87b96de3205d20423e7001523ad9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.46/stella-0.9.46-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9100f703943452e7653606108dea2c37f0ce0163694955eb6aa7feacd37dee60"
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
