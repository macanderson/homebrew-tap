# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.53 / @SHA_*@ placeholders below with
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
  version "0.9.53"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.53/stella-0.9.53-aarch64-apple-darwin.tar.gz"
      sha256 "363567afb808964edc4dbc4e2887b1caff2501a9322bf4a7b1cf7666e109c445"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.53/stella-0.9.53-x86_64-apple-darwin.tar.gz"
      sha256 "13c9ec9e00c96ea974522169ed89b6b606338b4ef9a73abfe2baf7058e3d33dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.53/stella-0.9.53-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fdafa6b0b7a4395fcbef3806b472b55f54f2601c05910d0374ee4d9eb3a3d80f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.53/stella-0.9.53-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d07e158e27c78a68988d23e6e567fa90cc38df8ce5e6dad5b581a635be44be8f"
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
