# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.38 / @SHA_*@ placeholders below with
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
  version "0.9.38"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.38/stella-0.9.38-aarch64-apple-darwin.tar.gz"
      sha256 "b917684cd68fd0ed4426a44901c7eaf0c8110171e491032bf10ce6c28ed0949a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.38/stella-0.9.38-x86_64-apple-darwin.tar.gz"
      sha256 "c0310139e1ee6a2d34ee461b0e2a7aadbe05d4d12591c010662db9c2f7ffdc4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.38/stella-0.9.38-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "854fa6510e20d71fd4e481c2c24e1596b82be9046ed3bbced5a3bd8ea1949d9a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.38/stella-0.9.38-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d50432944adbc9e6f951a9363e96a6d73f6d05d77d6d21805a542b639d9a7232"
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
