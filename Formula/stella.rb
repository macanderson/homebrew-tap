# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.358 / @SHA_*@ placeholders below with
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
  version "0.9.358"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.358/stella-0.9.358-aarch64-apple-darwin.tar.gz"
      sha256 "964b6a789c0b83f7952a5150b0f9d24b75626e89b1eb7a3466b884990b2d1494"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.358/stella-0.9.358-x86_64-apple-darwin.tar.gz"
      sha256 "3ac7bdff7f31545bbaf6f84f1fc584aa05bf5223738633224d2588f512d0790f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.358/stella-0.9.358-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9fe4c3ad62cec3cd97e15e3db002bbabfab53579f95b0fbaf93d18747084539a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.358/stella-0.9.358-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bad17f1b802a328c317f1422435f0904e8ed310489e6b6f0f999718fbf7a9c2f"
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
