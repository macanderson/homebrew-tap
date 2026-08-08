# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.29 / @SHA_*@ placeholders below with
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
  version "0.7.29"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.29/stella-0.7.29-aarch64-apple-darwin.tar.gz"
      sha256 "3491fa01df2389cab86ff545657bf1173d442cdae110322b6c5948c2db1385fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.29/stella-0.7.29-x86_64-apple-darwin.tar.gz"
      sha256 "e8b556979cce1fce8c34a42320fe977c0fe7b7fff3c77c440788199b9762643d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.29/stella-0.7.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "75aacacb705f65704c8c4c970a8ffa0adebe0a49d51e866487df0137c8b1b561"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.29/stella-0.7.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4d01f6b31e66bfa466163dcf1114b82028885a1527cd37757f27e0e0583924f7"
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
