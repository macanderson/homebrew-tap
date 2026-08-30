# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.281 / @SHA_*@ placeholders below with
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
  version "0.9.281"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.281/stella-0.9.281-aarch64-apple-darwin.tar.gz"
      sha256 "f0857e072453bc8ae38903d14902729b644fa054e1b5394a47d1330860be70e2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.281/stella-0.9.281-x86_64-apple-darwin.tar.gz"
      sha256 "90ff68cab41749d970062b6538d16c4d914c98b1349f4f1eab02755a895f56c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.281/stella-0.9.281-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1e1b56cb904f6bb79d3a68d994825d9b031a7b31b17ceff2b2cb8c4ccd96f8d9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.281/stella-0.9.281-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "58c0eae7a0deeca4f27c2a48ced94c111d0f9b8cbebf3a9898237be7180fbfe3"
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
