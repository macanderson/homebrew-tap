# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.19 / @SHA_*@ placeholders below with
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
  version "0.7.19"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.19/stella-0.7.19-aarch64-apple-darwin.tar.gz"
      sha256 "46f9e19e3d40680f085aa56a60242a2c47b28389676881edafd85b146a305cd0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.19/stella-0.7.19-x86_64-apple-darwin.tar.gz"
      sha256 "7c66d042338351f168742c20425157d37e11b8c0c27dd364fc52757ed852cbee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.19/stella-0.7.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "347e43eb713cd7dd41c4c5311f9db19d04a8aedc6d59fc9356010df35520a8e5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.19/stella-0.7.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f0cacc545082f5eff58da6986f211aa6b7856c3f8be7512914473e2c34ab71a"
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
