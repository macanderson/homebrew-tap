# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.193 / @SHA_*@ placeholders below with
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
  version "0.9.193"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.193/stella-0.9.193-aarch64-apple-darwin.tar.gz"
      sha256 "5007322272e825a59167f7e6b9c6c8dc2d57a7fbd17a83e805f5125bd5993864"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.193/stella-0.9.193-x86_64-apple-darwin.tar.gz"
      sha256 "c60c00ad055d3879b74f7800b1e9e64d86c687f0cc2f4abdfbda20fb70b2a124"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.193/stella-0.9.193-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2dfa1c222ac0a31767c1e83dd2d59e7bc866d34b9a88acd220c038d9df03193b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.193/stella-0.9.193-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "de504bc7a584478c46606250e09f51843a4e295ec18c76b56b8187d49d2442a0"
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
