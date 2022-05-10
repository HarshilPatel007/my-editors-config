local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    print("[!] telescope not found!")
    return
end
