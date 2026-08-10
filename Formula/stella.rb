# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.21 / @SHA_*@ placeholders below with
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
  version "0.8.21"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.21/stella-0.8.21-aarch64-apple-darwin.tar.gz"
      sha256 "5162bb23f64a60f5c9db22260780c7e5e57c5da1b681b139899c90e8bf818d4d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.21/stella-0.8.21-x86_64-apple-darwin.tar.gz"
      sha256 "f12cbdca6cf8fa69ac38cac3ef90fd587cb342c22216aa45931a4224dcf08c82"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.21/stella-0.8.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fe179001a957800f3e81000b5786a51e2ca8f9ac0b305169f86031e5633b38c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.21/stella-0.8.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6394b44c238725361c60e1f742a1b5e9e4051e70a720e39fc8068dd70ab5c6ec"
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
