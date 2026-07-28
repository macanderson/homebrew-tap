# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.64 / @SHA_*@ placeholders below with
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
  version "0.5.64"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.64/stella-0.5.64-aarch64-apple-darwin.tar.gz"
      sha256 "21860f34bc83d8260038692aa38c9d83950c5de46c4b368693001be8947d3faa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.64/stella-0.5.64-x86_64-apple-darwin.tar.gz"
      sha256 "c7257a4bc218ed0e899138782530ceb66de031fd2ac1df1d836d354f074f39a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.64/stella-0.5.64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f2992ea230f1049a4ed5d41075fa7f337456b975f75208974ed391c1f38095b6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.64/stella-0.5.64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bfe903f40a05aae4035e45967908b12f48630fbee6c59b309d7091aab3f7cc2d"
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
