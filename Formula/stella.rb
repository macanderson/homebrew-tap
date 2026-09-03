# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.320 / @SHA_*@ placeholders below with
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
  version "0.9.320"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.320/stella-0.9.320-aarch64-apple-darwin.tar.gz"
      sha256 "2df5530f4141b8e1383d758c4e3ea802e33e07fb9e87d37c02def7d6ef5f441d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.320/stella-0.9.320-x86_64-apple-darwin.tar.gz"
      sha256 "93e639795dbe7fd9953ccc558137a173b7d8130bdf75adf5ea8c35b994b29be8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.320/stella-0.9.320-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4c5a5a45097099c622cb76b1d99b0de93ad0bc7fc7a7c9e42084808fb7629483"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.320/stella-0.9.320-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a3349207004ac802239fd163a83d88e822fcb7fac305a965b7e894dc34f5b2db"
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
