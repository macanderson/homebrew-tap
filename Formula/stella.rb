# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.188 / @SHA_*@ placeholders below with
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
  version "0.9.188"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.188/stella-0.9.188-aarch64-apple-darwin.tar.gz"
      sha256 "54b55f2e94512c5d9d12a4240d196c12400fcd7e5f1b7ee31ef217d59d9f8861"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.188/stella-0.9.188-x86_64-apple-darwin.tar.gz"
      sha256 "20a5c4179078fe780b7090b60fc9a29e19295882b1beed78df92ae3d80eee8ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.188/stella-0.9.188-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73a2e93a6975cf1584e50eeb541a829e0efbbf4ecaee63fec032f22500689098"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.188/stella-0.9.188-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a2618383ad24b9d8fddbe75e400c82ae0ea08d5ed5975b8040dd0f51226ec927"
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
