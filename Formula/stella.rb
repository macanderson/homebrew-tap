# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.93 / @SHA_*@ placeholders below with
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
  version "0.9.93"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.93/stella-0.9.93-aarch64-apple-darwin.tar.gz"
      sha256 "c00595139b58945ef6f024bec6414f3ef6994498204b1c426044f590ec12f401"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.93/stella-0.9.93-x86_64-apple-darwin.tar.gz"
      sha256 "15d6c2f754889918ddf19cd660d9e98bbed7e082a4497e1e107478ab5ac28fbf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.93/stella-0.9.93-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1fc2f0dca12b1993811a0dc15efd4ba167150512548345f1358eff9f3a8496a4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.93/stella-0.9.93-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "841bfbcadab56d8cfaec7c9e42db91ecea49411c0f3a990175ea23d684cf87fc"
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
