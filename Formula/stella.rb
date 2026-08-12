# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.15 / @SHA_*@ placeholders below with
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
  version "0.9.15"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.15/stella-0.9.15-aarch64-apple-darwin.tar.gz"
      sha256 "2188f9f9d0e80d3ab9283f018dd8df7d17ab07b0c96cd37f32960d78d37406cf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.15/stella-0.9.15-x86_64-apple-darwin.tar.gz"
      sha256 "9f00dc1430937ac621253e92353fa07be677fa1937cdd201ee53de34f6c489d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.15/stella-0.9.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f701e245efc27e273dfbfc3ab513005da46d46b890e9c25beac7d4f82678f7f7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.15/stella-0.9.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b4b74a2f30a0393f2f091ea363a02521569294cde752d2f1220fcf673fa3bc6"
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
